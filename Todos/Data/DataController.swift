//
//  DataController.swift
//  Todos
//
//  Created by Hoolime Technologies Private Limited on 07/04/22.
//

import CoreData

let MODEL_NAME = "TodosDataModel"

class DataController: ObservableObject {
    static let shared = DataController()
    
    let container = NSPersistentContainer(name: MODEL_NAME)
    
    init() {
        container.loadPersistentStores { desc, err in
            if let err = err {
                print("Core Data: Failed to load \(MODEL_NAME)", err.localizedDescription)
            }
        }
    }
    
}
