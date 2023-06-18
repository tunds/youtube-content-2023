//
//  CreateCategoryView.swift
//  ToDos
//
//  Created by Tunde Adegoroye on 08/06/2023.
//

import SwiftUI

struct Category {
    
    var title: String
        
    init(title: String = "") {
        self.title = title
    }
}

struct CreateCategoryView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    
    var body: some View {
        List {
            Section("Category Title") {
                TextField("Enter title here",
                          text: $title)
                Button("Add Category") {
                    
                }
                .disabled(title.isEmpty)
            }
                        
        }
        .navigationTitle("Add Category")
        .toolbar {
            
            ToolbarItem(placement: .cancellationAction) {
                Button("Dismiss") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreateCategoryView()
            .modelContainer(for: Item.self)
    }
}
