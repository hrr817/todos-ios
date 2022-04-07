//
//  TodosApp.swift
//  Todos
//
//  Created by Hoolime Technologies Private Limited on 07/04/22.
//

import SwiftUI

@main
struct TodosApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
