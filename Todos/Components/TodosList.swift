//
//  TodosList.swift
//  Todos
//
//  Created by Hoolime Technologies Private Limited on 07/04/22.
//

import SwiftUI

struct TodosList: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.updatedAt, order: .reverse)], predicate: NSPredicate(format: "done == false")) var todos: FetchedResults<TodoItem>
    
    @State private var showEdit: Bool = false
    @State private var selectedTodo: TodoItem? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                ForEach(todos, id: \.self) { todo in
                    Text(todo.text ?? "")
                        .onTapGesture {
                            selectedTodo = todo
                            if selectedTodo != nil {
                                showEdit = true
                            }
                        }
                        .contextMenu(
                            ContextMenu(menuItems: {
                                // Mark as done
                                Button {
                                    withAnimation {
                                        markAsDone(todo: todo)
                                    }
                                } label: {
                                    Image(systemName: "checkmark")
                                    Text("Mark as done")
                                }
                                // Edit todo, navigate
                                Button {
                                    selectedTodo = todo
                                    showEdit = true
                                } label: {
                                    Image(systemName: "pencil")
                                    Text("Edit")
                                }
                                // Delete todo
                                Button {
                                    withAnimation {
                                        deleteTodo(todo: todo)
                                    }
                                } label: {
                                    Image(systemName: "trash")
                                    Text("Delete")
                                }
                            })
                        )
                }
                .onDelete { idxSet in
                    for i in idxSet {
                        deleteTodo(todo: todos[i])
                    }
                }
            }
            .listStyle(.plain)
            .sheet(isPresented: $showEdit) {
                selectedTodo = nil
            } content: {
                EditTodo(todo: selectedTodo)
            }

        }
    }
    
    func deleteTodo(todo: TodoItem) {
        do {
            moc.delete(todo)
            
            try moc.save()
        } catch {
            print("CoreData: Unable to delete todo")
        }
    }
    
    func markAsDone(todo: TodoItem) {
        do {
            try moc.performAndWait {
                todo.done = true
                try moc.save()
            }
        } catch {
            print("CoreData: Failed to mark todo as done")
        }
    }
}
