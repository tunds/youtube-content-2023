//
//  Introduction_to_NavigationStackApp.swift
//  Introduction to NavigationStack
//
//  Created by Tunde Adegoroye on 03/02/2023.
//

import SwiftUI

@main
struct Introduction_to_NavigationStackApp: App {
    
    @StateObject private var routerManager = NavigationRouter()
    @StateObject private var cartManager = ShoppingCartManager()
    @StateObject private var fetcher = ProductsFetcher()
    
    @State private var openedFromURL: URL?
    
    var body: some Scene {
        WindowGroup {
            TabView {
                MenuView()
                    .tabItem {
                        Label("Menu", systemImage: "menucard")
                    }
                    .environmentObject(cartManager)
                    .environmentObject(routerManager)
                    .environmentObject(fetcher)
                    .onOpenURL { url in
                        Task {
                            await handleDeeplinking(from: url)
                        }
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }

        }
    }
}

private extension Introduction_to_NavigationStackApp {
    
    func handleDeeplinking(from url: URL) async {
        
        let routeFinder = RouteFinder()
        if let route = await routeFinder.find(from: url,
                                              productsFetcher: fetcher) {
            routerManager.push(to: route)
        }
    }
}
