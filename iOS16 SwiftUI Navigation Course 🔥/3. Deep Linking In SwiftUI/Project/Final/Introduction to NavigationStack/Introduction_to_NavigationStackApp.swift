//
//  Introduction_to_NavigationStackApp.swift
//  Introduction to NavigationStack
//
//  Created by Tunde Adegoroye on 03/02/2023.
//

import SwiftUI

@main
struct Introduction_to_NavigationStackApp: App {
    
    @StateObject private var cartManager = ShoppingCartManager()
    @StateObject private var routerManager = NavigationRouter()
    @StateObject private var fetcher = ProductsFetcher()

    var body: some Scene {
        WindowGroup {
            MenuView()
                .environmentObject(routerManager)
                .environmentObject(cartManager)
                .environmentObject(fetcher)
                .onOpenURL { url in
                    Task {
                        await handleDeeplink(from: url)
                    }
                }
        }
    }
}

extension Introduction_to_NavigationStackApp {
    
    func handleDeeplink(from url: URL) async {
        let routeFinder = RouteFinder()
        if let route = await routeFinder.find(from: url, productsFetcher: fetcher) {
            routerManager.push(to: route)
        }
    }
}
