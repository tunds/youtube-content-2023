//
//  TipsItemView.swift
//  BuildingATipJar
//
//  Created by Tunde Adegoroye on 20/11/2022.
//

import SwiftUI
import StoreKit

struct TipsItemView: View {
    
    var body: some View {
        HStack {
            
            VStack(alignment: .leading,
                   spacing: 3) {
                Text("-")
                    .font(.system(.title3, design: .rounded).bold())
                Text("-")
                    .font(.system(.callout, design: .rounded).weight(.regular))
            }
            
            Spacer()
            
            Button("-") {
              
            }
            .tint(.blue)
            .buttonStyle(.bordered)
            .font(.callout.bold())
        }
        .padding(16)
        .background(Color(UIColor.systemBackground),
                    in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct TipsItemView_Previews: PreviewProvider {
    static var previews: some View {
        TipsItemView()
    }
}
