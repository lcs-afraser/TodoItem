//
//  TodoItem.swift
//  TodoItem
//
//  Created by Alistair Fraser on 2023-04-04.
//

import SwiftUI

struct TodoItem: Identifiable {
    var id: Int
    var description: String
    var completed: Bool
}

var existingTodoItems = [
    TodoItem(id: 1, description: "Do homework", completed: true)
    ,
    TodoItem(id: 2, description: "Take a nap", completed: false)
    ,
    TodoItem(id: 3, description: "Practice golf", completed: false)
    ,
]
