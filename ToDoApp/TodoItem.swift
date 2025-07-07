//
//  TodoItem.swift
//  ToDoApp
//
//  Created by Batuhan Mıcık on 7/7/25.
//

import Foundation

struct TodoItem: Identifiable, Codable {
    let id: UUID
    var title: String
    var isDone: Bool = false
    
    init(id: UUID = UUID(), title: String, isDone: Bool = false) {
        self.id = id
        self.title = title
        self.isDone = isDone
    }
}
