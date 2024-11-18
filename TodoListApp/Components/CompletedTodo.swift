


import SwiftUI
import SwiftData

struct CompletedTodoList: View {
    @Binding var showAll: Bool
    @Query private var completedList: [Todo]
    private let maxCount = 15
    init(showAll: Binding<Bool>) {
        
        var descriptor = FetchDescriptor(predicate: #Predicate<Todo> { $0.isCompleted }, sortBy: [SortDescriptor(\Todo.lastUpdated, order: .reverse)])
        
        if !showAll.wrappedValue {
            descriptor.fetchLimit = maxCount
        }
        
        _completedList = Query(descriptor, animation: .snappy)
        _showAll = showAll
    }
    
    var body: some View {
        Section {
            if completedList.isEmpty {
                ContentUnavailableView{
                    Label("No Completed Task", systemImage: "tray.fill")
                }
            } else {
                ForEach(completedList) { todo in
                    TodoRowView(todo: todo)
                }
            }
        } header: {
            HStack { 
                Text("Completed")
                
                Spacer(minLength: 0)
                
                if showAll && !completedList.isEmpty {
                    Button("Show Recent") {
                        showAll = false
                    }
                }
            }
            .font(.caption)
        } footer: {
            if completedList.count == maxCount && !showAll && !completedList.isEmpty {
                HStack {
                    Text("Showing Recent 15 Tasks")
                        .foregroundStyle(.gray)
                    
                    Spacer(minLength: 0)
                    
                    Button("Show All") {
                        showAll = true
                    }
                }
                .font(.caption)
            }
        }
        .animation(.snappy, value: showAll)
    }
}

#Preview {
    CompletedTodoList(showAll: .constant(true))
}
