//
//  UnitTestingAsyncCodeTests.swift
//  UnitTestingAsyncCodeTests
//
//  Created by Tunde Adegoroye on 25/01/2023.
//

import XCTest
@testable import UnitTestingAsyncCode

final class UnitTestingAsyncCodeTests: XCTestCase {

    
    private var sut: SampleNetworkingManager!
    
    override func setUp() {
        sut = .init()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testSuccessfulNetworkingCall() {
        
        sut.isSuccessfull = true
        sut.time = 10
        
        sut.getData { result in
            XCTAssertTrue(result)
        }
    }
}
