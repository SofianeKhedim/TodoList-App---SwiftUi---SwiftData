//
//  ContentView.swift
//  TodoListApp
//
//  Created by Sofiane Khedim on 05/11/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("Todo List")
                .modelContainer(for: Todo.self)
        }
    }
}

#Preview {
    ContentView()
}
