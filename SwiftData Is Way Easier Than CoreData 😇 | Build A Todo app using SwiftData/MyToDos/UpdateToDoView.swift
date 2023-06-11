//
//  UpdateToDoView.swift
//  MyToDos
//
//  Created by Tunde Adegoroye on 10/06/2023.
//

import SwiftUI
import SwiftData

struct UpdateToDoView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Bindable var item: ToDoItem
    
    var body: some View {
        List {
            TextField("Name", text: $item.title)
            DatePicker("Choose a date",
                       selection: $item.timestamp)
            Toggle("Important?", isOn: $item.isCritical)
            Button("Update") {
                dismiss()
            }
        }
        .navigationTitle("Update ToDo")
    }
}
