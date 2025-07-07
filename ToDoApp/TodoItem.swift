//
//  TodoItem.swift
//  ToDoApp
//
//  Created by Batuhan Mıcık on 7/7/25.
//

import Foundation

struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
    var isDone: Bool = false
}
