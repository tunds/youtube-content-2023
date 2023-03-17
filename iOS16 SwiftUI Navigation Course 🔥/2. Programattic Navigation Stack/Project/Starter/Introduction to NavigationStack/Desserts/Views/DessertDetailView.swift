//
//  DessertDetailView.swift
//  Introduction to NavigationStack
//
//  Created by Tunde Adegoroye on 04/02/2023.
//

import SwiftUI

struct DessertDetailView: View {
    
    @EnvironmentObject private var cartManager: ShoppingCartManager
    let dessert: Dessert
    
    var body: some View {
        List {
            
            Section {
                LabeledContent("Icon", value: dessert.name)
                LabeledContent("Name", value: dessert.title)
                LabeledContent {
                    Text(dessert.price,
                         format: .currency(code: Locale.current.currency?.identifier ?? ""))
                } label: {
                    Text("Price")
                }
                LabeledContent("Cold?", value: dessert.isCold ? "✅" : "❌")
            }
            
            Section("Description") {
                Text(dessert.description)
            }
            
            if dessert.allergies?.isEmpty == false ||
                dessert.ingredients?.isEmpty == false {
                
                Section("Dietry") {
                    
                    if let ingredientsCount = dessert.ingredients?.count {
                        let countVw = Text("x\(ingredientsCount)").font(.footnote).bold()
                        Text("\(countVw) Ingredients")
                    }
                    
                    if let allergiesCount = dessert.allergies?.count {
                        let countVw = Text("x\(allergiesCount)").font(.footnote).bold()
                        Text("\(countVw) Allergies")
                    }
                }
            }
            
            if dessert.locations?.isEmpty == false {
                
                Section("Locations") {
                    
                    if let locationsCount = dessert.locations?.count {
                        let countVw = Text("x\(locationsCount)").font(.footnote).bold()
                        Text("\(countVw) Locations")
                    }
                }
            }

            
            Section {
                Button {
                    cartManager.add(dessert)
                } label: {
                    Label("Add to cart", systemImage: "cart")
                        .symbolVariant(.fill)
                }
            }

        }
        .navigationTitle(dessert.title)
    }
}

struct DessertDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            
            DessertDetailView(dessert: desserts[0])
                .environmentObject(ShoppingCartManager())
        }
    }
}
