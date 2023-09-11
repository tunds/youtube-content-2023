//
//  ItemsContainer.swift
//  ToDos
//
//  Created by Tunde Adegoroye on 27/06/2023.
//

import Foundation
import SwiftData

actor ItemsContainer {
    
    @MainActor
    static func create(shouldCreateDefaults: inout Bool) -> ModelContainer {
        let schema = Schema([Item.self])
        let configuration = ModelConfiguration()
        let container = try! ModelContainer(for: schema, configurations: [configuration])
        if shouldCreateDefaults {
            shouldCreateDefaults = false
            
            let categories = DefaultsJSON.decode(from: "DefaultCategories", 
                                                 type: [Category].self)
            categories?.forEach { container.mainContext.insert($0) }
            
            let items = DefaultsJSON.decode(from: "DefaultToDos",
                                            type: [Item].self)
         
            items?.forEach { item in
            
                container.mainContext.insert(item)
                item.category?.items?.append(item)
            }

        }

        return container
    }
    
}
