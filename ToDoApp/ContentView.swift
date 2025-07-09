//
//  ContentView.swift
//  ToDoApp
//
//  Created by Batuhan Mıcık on 7/7/25.
//

import SwiftUI

struct ContentView: View {
    let storage = TodoStorage()
    @State private var newTodoDueDate: Date = Date()
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
                        .padding(10)
                        .background(Color(.systemGray6))
                        .textFieldStyle(.roundedBorder)
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity)
                        .onSubmit {
                            addTodo()
                        }
                    
                    Button(action: addTodo){
                        Image(systemName: "plus")
                            .padding()
                            .font(.title2)
                            .foregroundColor(.accentColor)
                    }
                    .disabled(newTodoText.isEmpty)
                    
                    
                }
                
                DatePicker("Due Date", selection: $newTodoDueDate, displayedComponents: .date)
                    .padding(.horizontal)
                
                Picker("Filter", selection: $selectedCategoryFilter){
                    Text("All").tag(Category?.none)
                    ForEach(Category.allCases){ category in
                        Text(category.rawValue).tag(Category?.some(category))
                    }
                }
                List{
                    ForEach(filteredTodos) { todo in
                        HStack{
                            VStack(alignment: .leading, spacing: 4){
                                Text(todo.title)
                                    .font(.title3)
                                    .strikethrough(todo.isDone)
                                
                                Text("Due: \(todo.dueDate.formatted(date: .abbreviated, time: .omitted))")
                                    .font(.subheadline)
                                    .background(.red.opacity(0.4))
                                    .opacity(0.7)
                            }
                            Spacer()
                            if selectedCategoryFilter == nil{
                                Text(todo.category.rawValue)
                                    .foregroundStyle(.gray)
                                    .font(.caption)
                            }
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
        todos.append(TodoItem(title: newTodoText, category: newTodoCategory, dueDate: newTodoDueDate))
        newTodoText = ""
        newTodoCategory = .personal
        newTodoDueDate = Date()
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
