//
//  AddTodo.swift
//  Todos
//
//  Created by Hoolime Technologies Private Limited on 07/04/22.
//

import SwiftUI

struct AddTodo: View {
    @Environment(\.managedObjectContext) var moc
    @State var text: String = ""
    
    var body: some View {
        HStack {
            TextField("", text: $text)
                .padding(.horizontal)
                .frame(maxHeight: .infinity)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(5)
            Button { // save todo
                withAnimation {
                    saveTodo()
                }
            } label: {
                Text("Add")
            }
            .frame(maxHeight: .infinity)
            .buttonStyle(.borderedProminent)
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding()
    }
    
    func saveTodo() {
        if text.isEmpty {
            return
        }
            
        do {
            let todo = TodoItem(context: moc)
            todo.id = UUID().uuidString
            todo.text = text
            todo.createdAt = Date()
            todo.updatedAt = Date()
            todo.done = false
            
            try moc.save()
            
            self.text = ""
        } catch {
            print("Unable to save")
        }
    }
}
