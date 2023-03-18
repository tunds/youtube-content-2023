//
//  Route.swift
//  Introduction to NavigationStack
//
//  Created by Tunde Adegoroye on 08/02/2023.
//

import Foundation
import SwiftUI

struct PromoData: Equatable {
    let desc: String
    let pct: Decimal
}

enum Route {
 
    case menuItem(item: any MenuItem)
    case cart
    case ingredients(items: [Ingredient])
    case allergies(items: [Allergie])
    case locations(places: [Location])
    case map(location: Location)
    case promo(data: PromoData)
    case invalidProduct
    
}

extension Route: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case (.menuItem(let lhsItem), .menuItem(let rhsItem)):
            return lhsItem.id == rhsItem.id
        case (.cart, .cart):
            return true
        case (.ingredients(let lhsItem), .ingredients(let rhsItem)):
            return lhsItem == rhsItem
        case (.allergies(let lhsItem), .allergies(let rhsItem)):
            return lhsItem == rhsItem
        case (.locations(let lhsItem), .locations(let rhsItem)):
            return lhsItem == rhsItem
        case (.map(let lhsItem), .map(let rhsItem)):
            return lhsItem.id == rhsItem.id
        case (.promo(let lhsItem), .promo(let rhsItem)):
            return lhsItem == rhsItem
        case (.invalidProduct, .invalidProduct):
            return true
        default:
            return false
        }
    }
    
}

extension Route: View {
    
    var body: some View {
        
        switch self {
            
        case .menuItem(let item):
            
            switch item {
                
            case is Food:
                FoodDetailView(food: item as! Food)
            case is Drink:
                DrinkDetailView(drink: item as! Drink)
            case is Dessert:
                DessertDetailView(dessert: item as! Dessert)
            default:
                EmptyView()
            }
        case .cart:
            CartView()
        case .ingredients(let items):
            IngredientsDetailView(ingredients: items)
        case .allergies(let items):
            AllergiesDetailView(allergies: items)
        case .locations(let places):
            LocationsDetailView(locations: places)
        case .map(let location):
            LocationMapView(location: location)
        case .promo(let data):
            PromoView(data: data)
        case .invalidProduct:
            InvalidProductView()
        }
    }
}

extension Route {
    
    static func buildDeepLink(from route: Route) -> URL? {
        
        switch route {
        case .menuItem(let item):
            
            let queryProductItem = item.title.replacingOccurrences(of: " ", with: "+")
            let queryProductId = "\(item.name)_\(queryProductItem)"

            var url = URL(string: "myfoodapp://product")!
            let queryItems = [URLQueryItem(name: "item", value: queryProductId)]
            
            url.append(queryItems: queryItems)
            
            return url
            
        default:
            return nil
        }
        
    }
}
