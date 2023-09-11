//
//  Item.swift
//  ToDos
//
//  Created by Tunde Adegoroye on 06/06/2023.
//

import Foundation
import SwiftData
import UIKit

@Model
final class Item: Codable {
    var title: String
    var timestamp: Date
    var isCritical: Bool
    var isCompleted: Bool

    @Relationship(deleteRule: .nullify, inverse: \Category.items)
    var category: Category?
    
    @Attribute(.externalStorage)
    var image: Data?
    
    enum CodingKeys: String, CodingKey {
        case title
        case timestamp
        case isCritical
        case isCompleted
        case category
        case imageName
    }
    
    init(title: String = "",
         timestamp: Date = .now,
         isCritical: Bool = false,
         isCompleted: Bool = false) {
        self.title = title
        self.timestamp = timestamp
        self.isCritical = isCritical
        self.isCompleted = isCompleted
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.timestamp = Date.randomDateNextWeek() ?? .now
        self.isCritical = try container.decode(Bool.self, forKey: .isCritical)
        self.isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
        self.category = try container.decodeIfPresent(Category.self, forKey: .category)
        
        if let imageName = try container.decodeIfPresent(String.self, forKey: .imageName),
           let imageData = UIImage(named: imageName) {
            self.image = imageData.jpegData(compressionQuality: 0.8)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(timestamp, forKey: .timestamp)
        try container.encode(isCritical, forKey: .isCritical)
        try container.encode(isCompleted, forKey: .isCompleted)
        try container.encode(category, forKey: .category)
    }
}

extension Date {
    static func randomDateNextWeek() -> Date? {
        let calendar = Calendar.current
        let currentDate = Date()
        
        guard let nextWeekStartDate = calendar.date(byAdding: .day, value: 7, to: currentDate) else {
            return nil
        }
        
        let randomTimeInterval = TimeInterval.random(in: 0..<7 * 24 * 60 * 60) // Random time within a week
        let randomDate = nextWeekStartDate.addingTimeInterval(randomTimeInterval)
        
        return randomDate
    }
}

extension Item {
    
    static var dummy: Item {
        .init(title: "Item 1",
              timestamp: .now,
              isCritical: true)
    }
    
    static func sample(_ count: Int) -> [Item] {
        
        let tempCategories = Category.sample(3)
        
        var items: [Item] = []
        for i in 0..<count {
            
            let hasCategory = Bool.random()
        
            let item = Item(title: "Item \(i)",
                            timestamp: Calendar.current.date(byAdding: .day,
                                                             value: i,
                                                             to: Date.now)!,
                            isCritical: Bool.random(),
                            isCompleted: Bool.random())
            
            if hasCategory {
                item.category = tempCategories.randomElement()
            }
            
            items.append(item)
            
        }
        return items
    }
}

