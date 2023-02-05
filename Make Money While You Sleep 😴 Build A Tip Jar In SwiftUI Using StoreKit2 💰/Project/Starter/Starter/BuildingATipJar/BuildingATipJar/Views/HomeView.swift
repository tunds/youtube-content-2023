//
//  HomeView.swift
//  BuildingATipJar
//
//  Created by Tunde Adegoroye on 20/11/2022.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showTips = false
    
    
    var body: some View {
        VStack {
            
            Button("Tip Me") {
                showTips.toggle()
            }
            .tint(.blue)
            .buttonStyle(.bordered)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            
            if showTips {
                Color.black.opacity(0.8)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        showTips.toggle()
                        
                    }
                TipsView {
                    showTips.toggle()
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.spring(), value: showTips)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
