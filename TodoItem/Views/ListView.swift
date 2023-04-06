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
    
    
    //Access the connection to the database(needed to add a new record)
    @Environment(\.blackbirdDatabase) var db:
    Blackbird.Database?
    
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
                        Task {
                            //Write to Database
                            try await db!.transaction { core in try core.query(" INSERT INTO TodoItem (description) VALUES(?)", newItemDescription)
                            }
                            //Clear the input field
                            newItemDescription = ""
                        }
                    }, label: {Text("ADD")
                            .font(.caption)
                    })
                }
                .padding(20)
                
                ForEach(todoItems.results) { currentItem in
                    
                    Label(title: { Text(currentItem.description)}, icon: {
                        if currentItem.completed == true {
                            Image(systemName: "checkmark.circle")
                        } else {
                            Image(systemName: "circle")
                        }
                    })
                    .onTapGesture {
                        Task {
                            try await db!.transaction { core in
                                //Change the status for this person to the opposite of its current value
                                try core.query("UPDATE TodoItem SET completed = (?) WHERE id = (?)",
                                               !currentItem.completed,
                                               currentItem.id)
                            }
                        }
                    }
                }
            }
            .navigationTitle("To-Do List")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
        //Make the database avaliable to all other views through the environment
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
