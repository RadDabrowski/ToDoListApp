//
//  ToDoItemListViewViewModel.swift
//  ToDoList
//
//  Created by Radosław Dąbrowski on 21/05/2023.
//


import FirebaseAuth
import FirebaseFirestore
import Foundation


/// ViewModel for single to do list item view (each row in items list)
/// Primary tab
class ToDoItemListViewViewModel: ObservableObject{
    init () {}

    
    
    func toggleIsDone(item: ToDoListItem){
        var itemCopy = item
        itemCopy.setDone(!item.isDone)
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(uid)
            .collection("todos")
            .document(itemCopy.id)
            .setData(itemCopy.asDictionary())
    }
}
