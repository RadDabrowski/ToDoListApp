//
//  User.swift
//  ToDoList
//
//  Created by Radosław Dąbrowski on 21/05/2023.
//

import Foundation


struct User: Codable{
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
