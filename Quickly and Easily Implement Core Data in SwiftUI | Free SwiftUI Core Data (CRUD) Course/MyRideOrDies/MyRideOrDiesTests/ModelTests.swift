//
//  ModelTests.swift
//  MyRideOrDiesTests
//
//  Created by Tunde Adegoroye on 10/12/2022.
//

import XCTest
@testable import MyRideOrDies

final class ModelTests: XCTestCase {
    
    private var provider: ContactsProvider!
    
    override func setUp() {
        provider = .shared
    }
    
    override func tearDown() {
        provider = nil
    }
    
    func testContactIsEmpty() {
        let contact = Contact.empty(context: provider.viewContext)
        XCTAssertEqual(contact.name, "")
        XCTAssertEqual(contact.phoneNumber, "")
        XCTAssertEqual(contact.email, "")
        XCTAssertEqual(contact.name, "")
        XCTAssertFalse(contact.isFavourite)
        XCTAssertTrue(Calendar.current.isDateInToday(contact.dob))
    }
    
    func testContactIsNotValid() {
        let contact = Contact.empty(context: provider.viewContext)
        XCTAssertFalse(contact.isValid)
    }
    
    func testContactIsValid() {
        let contact = Contact.preview(context: provider.viewContext)
        XCTAssertTrue(contact.isValid)
    }
    
    func testContactsBirthdayIsValid() {
        let contact = Contact.preview(context: provider.viewContext)
        XCTAssertTrue(contact.isBirthday)
    }
    
    func testContactsBirthdayIsNotValid() throws {
        let contact = try XCTUnwrap(Contact.makePreview(count: 2, in: provider.viewContext).last)
        XCTAssertFalse(contact.isBirthday)
    }
    
    func testMakeContactsPreviewIsValid() {
        
        let count = 5
        let contacts = Contact.makePreview(count: count, in: provider.viewContext)
        for i in 0..<contacts.count {
            let item = contacts[i]
            XCTAssertEqual(item.name, "item \(i)")
            XCTAssertEqual(item.email, "test_\(i)@mail.com")
            XCTAssertNotNil(item.isFavourite) // This can be random just make sure it's not nil
            XCTAssertEqual(item.phoneNumber, "0700000000\(i)")
            
            let dateToCompare = Calendar.current.date(byAdding: .day, value: -i, to: .now)
            let dobDay = Calendar.current.dateComponents([.day], from: item.dob, to: dateToCompare!).day
            
            XCTAssertEqual(dobDay, 0)
            XCTAssertEqual(item.notes, "This is a preview for item \(i)")
        }
    }
    
    func testFilterFaveContactsRequestIsValid() {
        let request = Contact.filter(with: .init(filter: .fave))
        XCTAssertEqual("isFavourite == 1", request.predicateFormat)
    }
    
    func testFilterAllFaveContactsRequestIsValid() {
        let request = Contact.filter(with: .init(filter: .all))
        XCTAssertEqual("TRUEPREDICATE", request.predicateFormat)
    }
    
    func testFilterAllWithQueryContactsRequestIsValid() {
        let query = "tunds"
        let request = Contact.filter(with: .init(query: query))
        XCTAssertEqual("name CONTAINS[cd] \"\(query)\"", request.predicateFormat)
    }
    
    func testFilterFaveWithQueryContactsRequestIsValid() {
        let query = "tunds"
        let request = Contact.filter(with: .init(query: query, filter: .fave))
        XCTAssertEqual("name CONTAINS[cd] \"\(query)\" AND isFavourite == 1", request.predicateFormat)
    }
}
