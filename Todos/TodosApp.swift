//
//  TodosApp.swift
//  Todos
//
//  Created by Hoolime Technologies Private Limited on 07/04/22.
//

import SwiftUI

@main
struct TodosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, DataController.shared.container.viewContext)
        }
    }
}
