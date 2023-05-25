//
//  LoginView.swift
//  ToDoList
//
//  Created by Radosław Dąbrowski on 21/05/2023.
//

import SwiftUI


struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()


     var body: some View {
        NavigationView{
            VStack{
                // Header
                HeaderView(title: "To Do List",
                           subtitle: "Get things done",
                           angle: 15,
                           background: Color.pink)
                // Login Form
                
                 
                Form{
                    if !viewModel.errorMessage.isEmpty{
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }
                    
                    TextField("Email Address", text:$viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                    
                    
                    SecureField("Password", text:$viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                     
                    TLButton(title: "Log in",
                             background: .blue
                    ) {
                        viewModel.login()
                    }
                    .padding()
                }
                .offset(y: -50)
            
                
                // Create Account
                VStack{
                    Text("New around here?")
                    NavigationLink("Create An Account", destination: RegisterView())
                    
                }
                .padding(.bottom, 50)
                
                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
