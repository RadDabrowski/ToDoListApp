//
//  ToDoListViewViewModel.swift
//  ToDoList
//
//  Created by Radosław Dąbrowski on 21/05/2023.
//

import Foundation


/// ViewModel for list of items view
/// Primary tab
class ToDoListViewViewModel: ObservableObject{
    @Published var showingNewItemView = false
    init () {} 
}
