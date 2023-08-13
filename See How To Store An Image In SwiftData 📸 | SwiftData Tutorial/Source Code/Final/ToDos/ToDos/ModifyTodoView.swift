//
//  ModifyTodoView.swift
//  ToDos
//
//  Created by Tunde Adegoroye on 06/06/2023.
//

import SwiftUI
import SwiftData
import PhotosUI

struct CreateTodoView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
        
    @Query private var categories: [Category]
    
    @State var item = Item()
    @State var selectedCategory: Category?
    @State var selectedPhoto: PhotosPickerItem?

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
                Button("Create") {
                    save()
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
                    save()
                    dismiss()
                }
                .disabled(item.title.isEmpty)
            }
        }
        .task(id: selectedPhoto) {
            if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                item.image = data
            }
        }
    }
}

private extension CreateTodoView {
    
    func save() {
        modelContext.insert(item)
        item.category = selectedCategory
        selectedCategory?.items?.append(item)
    }
}
//
// Xcode 15 Beta 2 has a previews bug so this is why we're commenting this out...
// Ref: https://mastodon.social/@denisdepalatis/110561280521551715
#Preview {
    NavigationStack {
        CreateTodoView()
            .modelContainer(for: Item.self)
    }
}
