//
//  ContentView.swift
//  ToDoApp
//
//  Created by Batuhan Mıcık on 7/7/25.
//

import SwiftUI

struct ContentView: View {
    @State private var todos: [TodoItem] = []
    @State private var newTodoText: String = ""
    
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack{
                    TextField("New task", text: $newTodoText)
                        .textFieldStyle(.roundedBorder)
                        .padding(.leading)
                    
                    Button(action: addTodo){
                        Image(systemName: "plus")
                            .padding()
                    }
                }
                List{
                    ForEach(todos) { todo in
                        HStack{
                            Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
                                .onTapGesture {
                                    toggleTodo(todo)
                                }
                            
                            Text(todo.title)
                                .strikethrough(todo.isDone)
                        }
                    }
                    .onDelete(perform: deleteTodo)
                }
            }
            .navigationTitle("To-Do List")
        }
    }
    
    private func addTodo(){
        guard !newTodoText.isEmpty else { return }
        todos.append(TodoItem(title: newTodoText))
        newTodoText = ""
    }
    private func toggleTodo(_ todo: TodoItem){
        if let index = todos.firstIndex(where: { $0.id == todo.id }){
            todos[index].isDone.toggle()
            
        }
    }
    private func deleteTodo(at offsets: IndexSet){
        todos.remove(atOffsets: offsets)
    }
}


#Preview {
    ContentView()
}
