//
//  SettingsView.swift
//  Introduction to NavigationStack
//
//  Created by Tunde Adegoroye on 11/02/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var manager = NotificationsManager()
    
    var body: some View {
        Button("Request Notification\n Permission") {
            Task {
                await manager.request()
                await manager.getAuthStatus()
            }
        }
        .buttonStyle(.bordered)
        .disabled(manager.hasPermission)
        .task {
            await manager.getAuthStatus()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
