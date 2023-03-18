//
//  PromoView.swift
//  Introduction to NavigationStack
//
//  Created by Tunde Adegoroye on 09/02/2023.
//

import SwiftUI

struct PromoView: View {
    
    let pct: Decimal = 0.5
    
    var body: some View {
        VStack {
            Text(pct, format: .percent)
                .padding(50)
                .font(.system(size: 60,
                              weight: .heavy,
                              design: .rounded))
                .background(
                    Circle().fill(.red)
                )
                .foregroundColor(.white)
            Text("Get this **Great Offer** 🔥🔥🔥")
                .font(.title2)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                .italic()
            Button("Apply Discount") {
                
            }
            .controlSize(.large)
            .buttonStyle(.bordered)
            .padding(.top, 16)
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}

struct PromoView_Previews: PreviewProvider {
    static var previews: some View {
        PromoView()
    }
}
