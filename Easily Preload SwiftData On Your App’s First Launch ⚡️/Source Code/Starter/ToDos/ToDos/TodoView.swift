//
//  TodoView.swift
//  ToDos
//
//  Created by Tunde Adegoroye on 06/06/2023.
//

import SwiftUI

struct TodoView: View {
    
    let item: Item
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if item.isCritical {
                Image(systemName: "exclamationmark.3")
                    .symbolVariant(.fill)
                    .foregroundColor(.red)
                    .font(.largeTitle)
                    .bold()
            }

            Text(item.title)
                .font(.largeTitle)
                .bold()
        
            Text("\(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                .font(.callout)
        }
        
    }
}

// Xcode 15 Beta 2 has a previews bug so this is why we're commenting this out...
// Ref: https://mastodon.social/@denisdepalatis/110561280521551715
//#Preview {
//    TodoView(item: Item.dummy)
//}
