//
//  DoneTodosList.swift
//  Todos
//
//  Created by Hrr817 on 07/04/22.
//

import SwiftUI

struct TodosDoneList: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.updatedAt, order: .reverse)], predicate: NSPredicate(format: "done == true")) var todos: FetchedResults<TodoItem>
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                ForEach(todos, id: \.self) { todo in
                    Text(todo.text ?? "")
                        .foregroundColor(Color(UIColor.systemGray3))
                        .contextMenu(
                            ContextMenu(menuItems: {
                                // Mark as done
                                Button {
                                    withAnimation {
                                        markAsNotDone(todo: todo)
                                    }
                                } label: {
                                    Text("Mark as not done")
                                }
                                // Delete todo
                                Button {
                                    withAnimation {
                                        deleteTodo(todo: todo)
                                    }
                                } label: {
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
        }
    }
    
    func deleteTodo(todo: TodoItem) {
        moc.delete(todo)
    }
    
    func markAsNotDone(todo: TodoItem) {
        do {
            try moc.performAndWait {
                todo.done = false
                try moc.save()
            }
        } catch {
            print("CoreData: Failed to mark todo as not done")
        }
    }
}
