//
//  ContentView.swift
//  ToDoApp
//
//  Created by Batuhan Mıcık on 7/7/25.
//

import SwiftUI

struct ContentView: View {
    let storage = TodoStorage()
    @State private var newTodoCategory: Category = .personal
    @State private var selectedCategoryFilter: Category? = nil
    @State private var todos: [TodoItem] = []
    @State private var newTodoText: String = ""
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16){
                Picker("Category", selection: $newTodoCategory){
                    ForEach(Category.allCases){ category in
                        Text(category.rawValue).tag(category)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                HStack{
                    
                    TextField("New task", text: $newTodoText)
                        .textFieldStyle(.roundedBorder)
                        .frame(maxWidth: .infinity)
                    
                    Button(action: addTodo){
                        Image(systemName: "plus")
                            .padding()
                    }
                }
                Picker("Filter", selection: $selectedCategoryFilter){
                    Text("All").tag(Category?.none)
                    ForEach(Category.allCases){ category in
                        Text(category.rawValue).tag(Category?.some(category))
                    }
                }
                List{
                    ForEach(filteredTodos) { todo in
                        HStack{
                            Text(todo.title)
                                .font(.title3)
                                .strikethrough(todo.isDone)
                            Spacer()
                            Text(todo.category.rawValue)
                                .foregroundStyle(.gray)
                                .font(.caption)
                            Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
                            
                        }
                        .padding(.horizontal)
                        .onTapGesture {
                            toggleTodo(todo)
                        }
                        .padding()
                        
                    }
                    .onDelete(perform: deleteTodo)
                }
                
               
            }
            .onAppear{
                todos = storage.load()
            }
            .navigationTitle("To-Do List")
        }
    }
    
    private func addTodo(){
        guard !newTodoText.isEmpty else { return }
        todos.append(TodoItem(title: newTodoText, category: newTodoCategory))
        newTodoText = ""
        newTodoCategory = .personal
        storage.save(todos)
    }
    private func toggleTodo(_ todo: TodoItem){
        if let index = todos.firstIndex(where: { $0.id == todo.id }){
            todos[index].isDone.toggle()
            storage.save(todos)
            
        }
    }
    private func deleteTodo(at offsets: IndexSet){
        todos.remove(atOffsets: offsets)
        storage.save(todos)
    }
    
    private var filteredTodos: [TodoItem] {
        if let filter = selectedCategoryFilter{
            return todos.filter { $0.category == filter }
        }else{
            return todos
        }
    }
}


#Preview {
    ContentView()
}
