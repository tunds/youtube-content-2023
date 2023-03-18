//
//  MenuView.swift
//  Introduction to NavigationStack
//
//  Created by Tunde Adegoroye on 03/02/2023.
//

import SwiftUI

struct MenuView: View {
    
    @StateObject private var cartManager = ShoppingCartManager()
    @StateObject private var routerManager = NavigationRouter()
    @StateObject private var fetcher = ProductsFetcher()
    
    var body: some View {
        
        NavigationStack(path: $routerManager.routes) {
            
            Group {
                switch fetcher.action {
                case .loading:
                    ProgressView()
                case .finished(let items):
                    List {
                        
                        ForEach(items, id: \.name) { section in
                            
                            Section(section.name) {
                                
                                ForEach(section.items, id: \.id) { item in
                                    
                                    let route = getRoute(for: item)
                                    NavigationLink(value: route) {
                                        MenuItemView(item: item)
                                    }
                                }

                            }
                            
                        }
                        
                    }
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            CartButton(count: cartManager.items.count) {
                                routerManager.push(to: .cart)
                            }
                        }
                    }
                default:
                    EmptyView()
                }
            }
            .navigationTitle("Menu")
            .navigationDestination(for: Route.self) { $0 }
            
        }
        .environmentObject(cartManager)
        .environmentObject(routerManager)
        .task {
            await fetcher.fetchProducts()
        }
    }
}

private extension MenuView {
    
    func getRoute(for item: any MenuItem) -> Route? {
        switch item {
        case is Food:
            return Route.menuItem(item: item as! Food)
        case is Drink:
            return Route.menuItem(item: item as! Drink)
        case is Dessert:
            return Route.menuItem(item: item as! Dessert)
        default:
            return nil
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
