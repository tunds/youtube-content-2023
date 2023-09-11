//
//  ContentView.swift
//  ToDos
//
//  Created by Tunde Adegoroye on 06/06/2023.
//

import SwiftUI
import SwiftData
import SwiftUIImageViewer

enum SortOption: String, CaseIterable {
    case title
    case date
    case category
}

extension SortOption {
    
    var systemImage: String {
        switch self {
        case .title:
            "textformat.size.larger"
        case .date:
            "calendar"
        case .category:
            "folder"
        }
    }
}

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State private var searchQuery = ""
    @State private var showCreateCategory = false
    @State private var showCreateToDo = false
    @State private var toDoToEdit: Item?
    
    @State private var isImageViewerPresented = false
    
    @State private var selectedSortOption = SortOption.allCases.first!
    
    var filteredItems: [Item] {
        
        if searchQuery.isEmpty {
            return items.sort(on: selectedSortOption)
        }
        
        let filteredItems = items.compactMap { item in
            
            let titleContainsQuery = item.title.range(of: searchQuery,
                                                      options: .caseInsensitive) != nil
            
            let categoryTitleContainsQuery = item.category?.title.range(of: searchQuery,
                                                                        options: .caseInsensitive) != nil
            
            return (titleContainsQuery || categoryTitleContainsQuery) ? item : nil
        }
        
        return filteredItems.sort(on: selectedSortOption)
        
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredItems) { item in
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                
                                if item.isCritical {
                                    Image(systemName: "exclamationmark.3")
                                        .symbolVariant(.fill)
                                        .foregroundColor(.red)
                                        .font(.largeTitle)
                                        .bold()
                                }
                                
                                Text(item.title)
                                    .font(.largeTitle)
                                    .bold()
                                
                                Text("\(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .shortened))")
                                    .font(.callout)
                                
                                if let category = item.category {
                                    Text(category.title)
                                        .foregroundStyle(Color.blue)
                                        .bold()
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                        .background(Color.blue.opacity(0.1),
                                                    in: RoundedRectangle(cornerRadius: 8,
                                                                         style: .continuous))
                                }
                                
                            }
                            
                            
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    item.isCompleted.toggle()
                                }
                            } label: {
                                
                                Image(systemName: "checkmark")
                                    .symbolVariant(.circle.fill)
                                    .foregroundStyle(item.isCompleted ? .green : .gray)
                                    .font(.largeTitle)
                            }
                            .buttonStyle(.plain)
                        }
                            if let selectedPhotoData = item.image,
                               let uiImage = UIImage(data: selectedPhotoData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity, maxHeight: 120)
                                    .clipShape(RoundedRectangle(cornerRadius: 10,
                                                                style: .continuous))
                                    .onTapGesture {
                                        isImageViewerPresented = true
                                    }
                                    .fullScreenCover(isPresented: $isImageViewerPresented) {
                                        SwiftUIImageViewer(image: Image(uiImage: uiImage))
                                            .overlay(alignment: .topTrailing) {
                                                Button {
                                                    isImageViewerPresented = false
                                                } label: {
                                                    Image(systemName: "xmark")
                                                        .font(.headline)
                                                }
                                                .buttonStyle(.bordered)
                                                .clipShape(Circle())
                                                .tint(.purple)
                                                .padding()
                                            }
                                    }
                            }
                        
                    }
                    .swipeActions {
                        
                        Button(role: .destructive) {
                            
                            withAnimation {
                                modelContext.delete(item)
                            }
                            
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                        
                        Button {
                            toDoToEdit = item
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.orange)
                        
                    }
                }
            }
            .navigationTitle("My To Do List")
            .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/, value: filteredItems)
            .searchable(text: $searchQuery,
                        prompt: "Search for a to do or a category")
            .overlay {
                if filteredItems.isEmpty {
                    ContentUnavailableView.search
                }
            }
            .sheet(item: $toDoToEdit,
                   onDismiss: {
                toDoToEdit = nil
            },
                   content: { editItem in
                NavigationStack {
                    UpdateToDoView(item: editItem)
                        .interactiveDismissDisabled()
                }
            })
            .sheet(isPresented: $showCreateCategory,
                   content: {
                NavigationStack {
                    CreateCategoryView()
                }
            })
            .sheet(isPresented: $showCreateToDo,
                   content: {
                NavigationStack {
                    CreateTodoView()
                }
            })
            .toolbar {
                
                ToolbarItemGroup(placement: .primaryAction) {
                    Button {
                        showCreateCategory.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    
                    Menu {
                        Picker("", selection: $selectedSortOption) {
                            ForEach(SortOption.allCases,
                                    id: \.rawValue) { option in
                                Label(option.rawValue.capitalized,
                                      systemImage: option.systemImage)
                                .tag(option)
                            }
                        }
                        .labelsHidden()
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .symbolVariant(.circle)
                    }
                    
                }
                
            }
            .safeAreaInset(edge: .bottom,
                           alignment: .leading) {
                Button(action: {
                    showCreateToDo.toggle()
                }, label: {
                    Label("New ToDo", systemImage: "plus")
                        .bold()
                        .font(.title2)
                        .padding(8)
                        .background(.gray.opacity(0.1),
                                    in: Capsule())
                        .padding(.leading)
                        .symbolVariant(.circle.fill)
                    
                })
                
            }
        }
    }
    
    private func delete(item: Item) {
        withAnimation {
            modelContext.delete(item)
        }
    }
}

private extension [Item] {
    
    func sort(on option: SortOption) -> [Item] {
        switch option {
        case .title:
            self.sorted(by: { $0.title < $1.title })
        case .date:
            self.sorted(by: { $0.timestamp < $1.timestamp })
        case .category:
            self.sorted(by: {
                guard let firstItemTitle = $0.category?.title,
                      let secondItemTitle = $1.category?.title else { return false }
                return firstItemTitle < secondItemTitle
            })
        }
    }
}

// Xcode 15 Beta 2 has a previews bug so this is why we're commenting this out...
// Ref: https://mastodon.social/@denisdepalatis/110561280521551715
//#Preview {
//    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
//}
