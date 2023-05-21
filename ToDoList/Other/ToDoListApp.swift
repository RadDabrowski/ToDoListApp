//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Radosław Dąbrowski on 21/05/2023.
//

import FirebaseCore
import SwiftUI

@main
struct ToDoListApp: App {
    init () {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
