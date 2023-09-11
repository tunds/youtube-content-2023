//
//  CreateCategoryView.swift
//  ToDos
//
//  Created by Tunde Adegoroye on 08/06/2023.
//

import SwiftUI
import SwiftData

@Model
class Category: Codable {
    
    @Attribute(.unique)
    var title: String
    
    var items: [Item]?
    
    init(title: String = "") {
        self.title = title
    }
    
    enum CodingKeys: String, CodingKey {
        case title
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
    }
}

extension Category {
    
    static func sample(_ count: Int) -> [Category] {
        var categories: [Category] = []
        for i in 0..<count {
            categories.append(.init(title: "Category \(i)"))
        }
        return categories
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
