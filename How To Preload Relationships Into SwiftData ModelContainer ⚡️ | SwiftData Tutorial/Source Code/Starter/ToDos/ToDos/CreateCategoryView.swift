//
//  CreateCategoryView.swift
//  ToDos
//
//  Created by Tunde Adegoroye on 08/06/2023.
//

import SwiftUI
import SwiftData

@Model
class Category {
    
    @Attribute(.unique)
    var title: String
    
    var items: [Item]?
    
    init(title: String = "") {
        self.title = title
    }
}

extension Category {
    
    static var defaults: [Category] {
        [
            .init(title: "🙇🏾‍♂️ Study"),
            .init(title: "🤝 Routine"),
            .init(title: "🏠 Family")
        ]
    }
}

struct CreateCategoryView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var title: String = ""
    @Query private var categories: [Category]
    
    var body: some View {
        List {
            Section("Category Title") {
                TextField("Enter title here",
                          text: $title)
                Button("Add Category") {
                    withAnimation {
                        let category = Category(title: title)
                        modelContext.insert(category)
                        category.items = []
                        title = ""
                    }
                }
                .disabled(title.isEmpty)
            }
            
            Section("Categories") {
                
                if categories.isEmpty {
                    
                    ContentUnavailableView("No Categories",
                                           systemImage: "archivebox")
                    
                } else {
                    
                    ForEach(categories) { category in
                        Text(category.title)
                            .swipeActions {
                                Button(role: .destructive) {
                                    withAnimation {
                                        modelContext.delete(category)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                            }
                    }
                }
                

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

// Xcode 15 Beta 2 has a previews bug so this is why we're commenting this out...
// Ref: https://mastodon.social/@denisdepalatis/110561280521551715//#Preview {
//    NavigationStack {
//        CreateCategoryView()
//    }
//}
