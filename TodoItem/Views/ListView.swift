//
//  ListView.swift
//  TodoItem
//
//  Created by Alistair Fraser on 2023-04-04.
//
import Blackbird
import SwiftUI

struct ListView: View {
    //MARK: Stored Properties
    
    //The list of items to be completed
    @BlackbirdLiveModels({db in
        try await TodoItem.read(from: db)
    }) var todoItems
    
    //The items currently being added
    @State var newItemDescription: String = ""
    
    //MARK: Computed Properties
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter a to-do item",text: $newItemDescription)
                    
                    Button(action: {
//                        //Get last todo item id
//                        let lastId = todoItems.last!.id
//
//                        //Create new todo item id
//                        let newId = lastId + 1
//
//                        //Create new todo item
//                        let newTodoItem = TodoItem(id: newId, description: newItemDescription, completed: false)
//
//                        //Add the new todo item to the list
//                        todoItems.append(newTodoItem)
//
//                        //Clears the input field
//                        newItemDescription = ""
                        
                    }, label: {Text("ADD")
                            .font(.caption)
                    })
                }
                .padding(20)
                
                List(todoItems.results) { currentItem in
                    
                    Label(title: { Text(currentItem.description)}, icon: {
                        if currentItem.completed == true {
                            Image(systemName: "checkmark.circle")
                        } else {
                            Image(systemName: "circle")
                        }
                    })
                }
            }
            .navigationTitle("To-Do List")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
