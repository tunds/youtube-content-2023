//
//  ToDosApp.swift
//  ToDos
//
//  Created by Tunde Adegoroye on 06/06/2023.
//

import SwiftUI
import SwiftData

@main
struct ToDosApp: App {

    @AppStorage("isFirstTimeLaunch") private var isFirstTimeLaunch: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(ItemsContainer.create(shouldCreateDefaults: &isFirstTimeLaunch))
    }
}
