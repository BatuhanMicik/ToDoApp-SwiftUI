//
//  TodoStorage.swift
//  ToDoApp
//
//  Created by Batuhan Mıcık on 7/7/25.
//

import Foundation

class TodoStorage {
    private let key = "todo_items"
    
    func save(_ todos: [TodoItem]){
        if let data = try? JSONEncoder().encode(todos){
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func load() -> [TodoItem] {
        guard let data = UserDefaults.standard.data(forKey: key),
            let saveTodos = try? JSONDecoder().decode([TodoItem].self, from: data) else{
            return []
        }
        return saveTodos
    }
}
