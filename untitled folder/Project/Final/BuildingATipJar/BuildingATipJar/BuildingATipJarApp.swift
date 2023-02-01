//
//  BuildingATipJarApp.swift
//  BuildingATipJar
//
//  Created by Tunde Adegoroye on 16/11/2022.
//

import SwiftUI

@main
struct BuildingATipJarApp: App {
    
    @StateObject private var store = TipsStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
