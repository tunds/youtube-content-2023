//
//  Person.swift
//  UIKitForSwiftUIDevs
//
//  Created by Tunde Adegoroye on 02/11/2022.
//

struct PersonResponse: Codable {
    let data: [Person]
}

struct Person: Codable {
    let email: String
    let firstName: String
    let lastName: String
}
