//
//  TodoItemApp.swift
//  TodoItem
//
//  Created by Alistair Fraser on 2023-04-04.
//
import Blackbird
import SwiftUI

@main
struct TodoItemApp: App {
    var body: some Scene {
        WindowGroup {
            ListView()
            //Make the database avaliable to all other views through the environment
                .environment(\.blackbirdDatabase, AppDatabase.instance)
        }
    }
}
