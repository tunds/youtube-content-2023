//
//  ContentView.swift
//  BuildingATipJar
//
//  Created by Tunde Adegoroye on 16/11/2022.
//

import StoreKit
import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var store: TipsStore
    @State private var showTips = false
    @State private var showThanks = false

    var body: some View {
        
        VStack {
            
            Button("Tip Me") {
                showTips.toggle()
            }
            .tint(.blue)
            .buttonStyle(.bordered)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            
            if showThanks {
                
                VStack(spacing: 8) {
                    
                    Text("Thank You 💕")
                        .font(.system(.title2, design: .rounded).bold())
                        .multilineTextAlignment(.center)
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                        .font(.system(.body, design: .rounded))
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 16)
                    
                    Button {
                        showThanks.toggle()
                    } label: {
                        Text("Close")
                            .font(.system(.title3, design: .rounded).bold())
                            .tint(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(.blue, in: RoundedRectangle(cornerRadius: 10,
                                                                    style: .continuous))

                    }
                }
                .padding(16)
                .background(Color("card-background"), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                .padding(.horizontal, 8)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
         
        }
        .overlay {
            
            if showTips {
                Color.black.opacity(0.8)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        showTips.toggle()
                        
                    }
                cardVw
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.spring(), value: showTips)
        .animation(.spring(), value: showThanks)
        .onChange(of: store.action) { action in
                        
            if action == .successful {
                
                showTips = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    
                    showThanks.toggle()

                }
                
                store.reset()
            }
            
        }
        .alert(isPresented: $store.hasError, error: store.error) { }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TipsStore())
    }
}

private extension ContentView {
    
    var cardVw: some View {
                
        VStack(spacing: 8) {
            
            HStack {
                Spacer()
                Button {
                    showTips.toggle()
                } label: {
                    
                    Image(systemName: "xmark")
                        .symbolVariant(.circle.fill)
                        .font(.system(.largeTitle, design: .rounded).bold())
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.gray, .gray.opacity(0.2))
                }
            }
            
            Text("Enjoying the app so far? 👀")
                .font(.system(.title2, design: .rounded).bold())
                .multilineTextAlignment(.center)
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                .font(.system(.body, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
            
            ForEach(store.items) { item in
                configureProductVw(item)
            }
            
        }
        .padding(16)
        .background(Color("card-background"), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(8)
        .overlay(alignment: .top) {
            Image("logo")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(6)
                .background(Color.accentColor, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                .offset(y: -25)
        }
    }
    
    func configureProductVw(_ item: Product) -> some View {
        
        
        HStack {
            
            VStack(alignment: .leading,
                   spacing: 3) {
                Text(item.displayName)
                    .font(.system(.title3, design: .rounded).bold())
                Text(item.description)
                    .font(.system(.callout, design: .rounded).weight(.regular))
            }
            
            Spacer()
            
            Button(item.displayPrice) {
                Task {
                    await store.purchase(item)
                }
            }
            .tint(.blue)
            .buttonStyle(.bordered)
            .font(.callout.bold())
        }
        .padding(16)
        .background(Color("cell-background"),
                    in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        
    }
}

struct ProductsListView: View {
    
    @EnvironmentObject private var store: TipsStore

    var body: some View {
        
        ForEach(store.items) { item in
            ProductView(item: item)
        }
    }
}

struct ProductView: View {
    
    let item: Product
    var body: some View {
        HStack {
            
            VStack(alignment: .leading,
                   spacing: 3) {
                Text(item.displayName)
                    .font(.system(.title3, design: .rounded).bold())
                Text(item.description)
                    .font(.system(.callout, design: .rounded).weight(.regular))
            }
            
            Spacer()
            
            Button(item.displayPrice) {
                // TODO: Handle purchase
            }
            .tint(.blue)
            .buttonStyle(.bordered)
            .font(.callout.bold())
        }
    }
}
