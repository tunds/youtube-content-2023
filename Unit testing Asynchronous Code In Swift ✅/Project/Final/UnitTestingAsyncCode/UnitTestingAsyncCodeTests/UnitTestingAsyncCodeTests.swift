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
        
        let expectation = XCTestExpectation(description: "Call a network async")
        
        sut.isSuccessfull = true
        sut.time = 3
        
        sut.getData { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testMultipleSuccessfulNetworkingCall() {
        
        let expectation = XCTestExpectation(description: "Call Multiple a network async")
        expectation.expectedFulfillmentCount = 2
        
        sut.isSuccessfull = true
        sut.time = 3
        
        sut.getData { result in
            
            self.sut.isSuccessfull = false
            self.sut.time = 5
            
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
            
            self.sut.getData { result in
                
                switch result {
                case .success:
                    XCTFail()
                case .failure:
                    expectation.fulfill()
                }
            }
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func testSwiftConcurrencySuccesfulNetworkingCall() async throws {
        
        sut.isSuccessfull = true
        sut.time = 3
        _ = try await sut.getData()
        
    }
    
    func testMultipleSwiftConcurrencySuccesfulNetworkingCall() async throws {

        sut.isSuccessfull = true
        sut.time = 3
        _ = try await sut.getData()

        sut.isSuccessfull = false
        sut.time = 3
        do {
            _ = try await sut.getData()
            XCTFail()
        } catch {
            print("All good")
        }
    }
}
