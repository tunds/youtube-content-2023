//
//  ProductsFetcher.swift
//  Introduction to NavigationStack
//
//  Created by Tunde Adegoroye on 09/02/2023.
//

import Foundation

// Data
let products = [
    MenuSection(name: "Foods",
                items: foods),
    MenuSection(name: "Drinks",
                items: drinks),
    MenuSection(name: "Desserts",
                items: desserts),
]

@MainActor
final class ProductsFetcher: ObservableObject {
    
    enum Action {
        case loading
        case finished(items: [MenuSection])
    }
    
    @Published private(set) var action: Action?
    
    func fetchProducts() async {
        
        guard action == nil else {
            return
        }
        
        action = .loading
        
        // 2 second delay
        let duration = UInt64(2 * 1_000_000_000)
        try? await Task.sleep(nanoseconds: duration)
        
        action = .finished(items: products)
    }
}
