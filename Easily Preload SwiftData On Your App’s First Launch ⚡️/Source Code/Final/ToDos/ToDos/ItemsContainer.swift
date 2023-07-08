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
            Category.defaults.forEach {
                container.mainContext.insert($0)
            }
        }

        return container
    }
    
}
