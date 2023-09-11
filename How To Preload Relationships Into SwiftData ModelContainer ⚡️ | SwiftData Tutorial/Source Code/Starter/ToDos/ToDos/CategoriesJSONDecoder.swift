//
//  CategoriesJSONDecoder.swift
//  ToDos
//
//  Created by Tunde Adegoroye on 03/07/2023.
//

import Foundation

struct CategoryResponse: Codable {
    let title: String
}

struct CategoriesJSONDecoder {
    
    static func decode(from fileName: String) -> [CategoryResponse] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let categories = try? JSONDecoder().decode([CategoryResponse].self, from: data)  else {
            return []
        }

        return categories
    }
}
