//
//  Category.swift
//  ToDoApp
//
//  Created by Batuhan Mıcık on 7/7/25.
//

import Foundation

enum Category: String, CaseIterable, Codable, Identifiable {
    case personal = "Personal"
    case work = "Work"
    case shopping = "Shopping"
    case other = "Other"
    
    var id: String {
        self.rawValue
        
    }
}
