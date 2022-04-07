//
//  ContentView.swift
//  Todos
//
//  Created by Hoolime Technologies Private Limited on 07/04/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                AddTodo()
                TabView {
                    TodosList()
                        .navigationTitle("Todo")
                        .tabItem {
                            Image(systemName: "note.text")
                        }
                    TodosDoneList()
                        .navigationTitle("Done")
                        .tabItem {
                            Image(systemName: "checkmark.rectangle")
                        }
                }
                .menuIndicator(.hidden)
            }
        }
    }
}
