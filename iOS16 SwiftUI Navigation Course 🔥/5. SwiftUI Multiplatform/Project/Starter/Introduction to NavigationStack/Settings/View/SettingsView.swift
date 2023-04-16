//
//  SettingsView.swift
//  Introduction to NavigationStack
//
//  Created by Tunde Adegoroye on 11/02/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var manager = NotificationsManager()
    
    @AppStorage("layoutExperience")
    var layoutExperience: LayoutExperienceSetting?
    
    var body: some View {
        ScrollView {
            VStack {
                if UIDevice.current.userInterfaceIdiom != .phone {
                    LayoutExperienceView(selectedLayoutExperience: $layoutExperience)
                }
                
                Button("Request Notification\n Permission") {
                    Task {
                        await manager.request()
                        await manager.getAuthStatus()
                    }
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.bordered)
                .disabled(manager.hasPermission)
                .task {
                    await manager.getAuthStatus()
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView()
        }
    }
}
