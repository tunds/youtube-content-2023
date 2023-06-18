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

#Preview {
    TodoView(item: .dummy)
}
