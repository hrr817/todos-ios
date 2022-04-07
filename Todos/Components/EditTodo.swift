//
//  EditTodo.swift
//  Todos
//
//  Created by Hrr817 on 07/04/22.
//

import SwiftUI

struct EditTodo: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    var todo: TodoItem?
    
    @State private var text: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField("", text: $text)
                    .padding(.horizontal)
                    .frame(maxHeight: .infinity)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(5)
                Button { // update todo
                    withAnimation {
                        updateTodo()
                    }
                } label: {
                    Text("Save")
                }
                .frame(maxHeight: .infinity)
                .buttonStyle(.borderedProminent)
            }
            .fixedSize(horizontal: false, vertical: true)
            .onAppear {
                text = todo?.text ?? ""
            }
            
            Text("Last edited on \(todo?.updatedAt?.formatted() ?? "")")
                .foregroundColor(.gray)
                .font(.footnote)
            
            Text("Made on \(todo?.createdAt?.formatted() ?? "")")
                .foregroundColor(.gray)
                .font(.footnote)
            
            Spacer()
        }
        .padding()
    }
    
    func updateTodo() {
        do {
            try moc.performAndWait {
                todo?.text = text
                todo?.updatedAt = Date()
                try moc.save()
                presentationMode.wrappedValue.dismiss()
            }
        } catch {
            print("CoreData: Failed to save todo", todo?.text)
        }
    }
}
