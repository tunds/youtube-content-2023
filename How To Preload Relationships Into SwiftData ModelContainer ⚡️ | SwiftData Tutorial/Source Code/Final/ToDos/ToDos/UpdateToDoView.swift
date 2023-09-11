//
//  UpdateToDoView.swift
//  ToDos
//
//  Created by Tunde Adegoroye on 08/06/2023.
//

import SwiftUI
import SwiftData
import PhotosUI

class OriginalToDo {
    var title: String
    var timestamp: Date
    var isCritical: Bool
    
    init(item: Item) {
        self.title = item.title
        self.timestamp = item.timestamp
        self.isCritical = item.isCritical
    }
}

struct UpdateToDoView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Query private var categories: [Category]
    
    @State var selectedCategory: Category?
    @State var selectedPhoto: PhotosPickerItem?

    @Bindable var item: Item

    var body: some View {
        List {
            
            Section("To do title") {
                TextField("Name", text: $item.title)
            }
            
            Section("General") {
                DatePicker("Choose a date",
                           selection: $item.timestamp)
                Toggle("Important?", isOn: $item.isCritical)
            }
            
            
            
            Section("Select A Category") {
                
                
                if categories.isEmpty {
                    
                    ContentUnavailableView("No Categories",
                                           systemImage: "archivebox")
                    
                } else {
                    
                    Picker("", selection: $selectedCategory) {
                        
                        ForEach(categories) { category in
                            Text(category.title)
                                .tag(category as Category?)
                        }
                        
                        Text("None")
                            .tag(nil as Category?)
                    }
                    .labelsHidden()
                    .pickerStyle(.inline)
                }
                

            }
            
            Section {
                
                if let selectedPhotoData = item.image,
                   let uiImage = UIImage(data: selectedPhotoData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                }
                
                PhotosPicker(selection: $selectedPhoto,
                             matching: .images,
                             photoLibrary: .shared()) {
                    Label("Add Image", systemImage: "photo")
                }
                
                if item.image != nil {
                    
                    Button(role: .destructive) {
                        withAnimation {
                            selectedPhoto = nil
                            item.image = nil
                        }
                    } label: {
                        Label("Remove Image", systemImage: "xmark")
                            .foregroundStyle(.red)
                    }
                }
 
            }
            
            Section {
                Button("Update") {
                    item.category = selectedCategory
                    dismiss()
                }
            }
        }
        .navigationTitle("Update ToDo")
        .onAppear(perform: {
            selectedCategory = item.category
        })
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                item.image = data
            }
        }
    }
}

// Xcode 15 Beta 2 has a previews bug so this is why we're commenting this out...
// Ref: https://mastodon.social/@denisdepalatis/110561280521551715
//#Preview {
//    UpdateToDoView(item: Item.dummy)
//        .modelContainer(for: Item.self)
//
//}
