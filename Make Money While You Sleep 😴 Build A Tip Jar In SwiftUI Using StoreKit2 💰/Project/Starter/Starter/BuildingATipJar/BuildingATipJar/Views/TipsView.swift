//
//  TipsView.swift
//  BuildingATipJar
//
//  Created by Tunde Adegoroye on 20/11/2022.
//

import SwiftUI

struct TipsView: View {
        
    var didTapClose: () -> ()
    
    var body: some View {
        VStack(spacing: 8) {
            
            HStack {
                Spacer()
                Button(action: didTapClose) {
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
            
            ForEach(0...3, id: \.self) { _ in
                TipsItemView()
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
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        TipsView {}
    }
}
