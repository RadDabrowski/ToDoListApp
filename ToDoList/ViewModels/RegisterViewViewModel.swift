//
//  RegisterViewViewModel.swift
//  ToDoList
//
//  Created by Radosław Dąbrowski on 21/05/2023.
//
import FirebaseFirestore
import FirebaseAuth
import Foundation


class RegisterViewViewModel: ObservableObject{
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    func register (){
        guard validate() else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let userId = result?.user.uid else {
                return
            }
            self?.insertUserRecord(id: userId)
        }
    }
    
    private func insertUserRecord(id: String){
        let newUser = User(id: id,
                           name: name,
                           email: email,
                           joined: Date().timeIntervalSince1970)
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    private func validate() -> Bool{
        errorMessage = ""
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else{
            errorMessage = "Please fill in all fields"
            return false
        }
        
        
        let uppercaseLetterRegex = ".*[A-Z]+.*"
        let specialCharacterRegex = ".*[^A-Za-z0-9]+.*"
        let digitRegex = ".*\\d+.*"

        let uppercaseLetterPredicate = NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegex)
        let specialCharacterPredicate = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex)
        let digitPredicate = NSPredicate(format: "SELF MATCHES %@", digitRegex)

        guard uppercaseLetterPredicate.evaluate(with: password),
              specialCharacterPredicate.evaluate(with: password),
              digitPredicate.evaluate(with: password),
            password.count >= 8 else {
            errorMessage = "The password should contain at least 8 characters, at least 1 capital letter, 1 digit and a 1 special character"
            return false
        }

        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        guard emailPredicate.evaluate(with: email) else {
            errorMessage = "Please enter valid email"
            return false
        }
        
        return true
    }

}
