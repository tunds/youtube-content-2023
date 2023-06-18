//
//  ModifyTodoView.swift
//  ToDos
//
//  Created by Tunde Adegoroye on 06/06/2023.
//

import SwiftUI

struct CreateTodoView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
        
    @State var item = Item()
    @State var selectedCategory: Category?
    
    var body: some View {
        List {
            
            Section("To do title") {
                TextField("Name", text: $item.title)
            }
            
            Section {
                DatePicker("Choose a date",
                           selection: $item.timestamp)
                Toggle("Important?", isOn: $item.isCritical)
            }

            
            Section {
                Button("Create") {
                    dismiss()
                }
            }

        }
        .navigationTitle("Create ToDo")
        .toolbar {
            
            ToolbarItem(placement: .cancellationAction) {
                Button("Dismiss") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button("Done") {
                    dismiss()
                }
                .disabled(item.title.isEmpty)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreateTodoView()
            .modelContainer(for: Item.self)
    }
}
