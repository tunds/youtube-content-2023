//
//  MyToDosApp.swift
//  MyToDos
//
//  Created by Tunde Adegoroye on 10/06/2023.
//

import SwiftUI
import SwiftData

@main
struct MyToDosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: ToDoItem.self)
        }
    }
}
