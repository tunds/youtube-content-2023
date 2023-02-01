//
//  AppReviewAndRatingsTests.swift
//  AppReviewAndRatingsTests
//
//  Created by Tunde Adegoroye on 22/01/2023.
//

import XCTest
@testable import AppReviewAndRatings

final class AppReviewAndRatingsTests: XCTestCase {

    private var userDefaults: UserDefaults!
    private var manager: ReviewsRequestManager!
    
    override func setUp() {
        userDefaults = UserDefaults(suiteName: #file)
        manager = ReviewsRequestManager(userDefaults: userDefaults)
    }
    
    override func tearDown() {
        userDefaults.removePersistentDomain(forName: #file)
    }
    
    func testCountIsIncreasedWhenCalled() {
        XCTAssertEqual(0, manager.count, "The inital value should be 0")
        manager.increase()
        XCTAssertEqual(1, manager.count, "The new value should be 1")
        XCTAssertEqual(1, userDefaults.integer(forKey: manager.reviewCountKey), "The new value should be 1 in userdefaults")
    }

    func testAppIsValidForRequestOnFreshLaunch() {
        
        for _ in 0..<manager.limit {
            manager.increase()
        }
        
        XCTAssertTrue(manager.canAskForReview(), "The limit(\(manager.limit)) has been reached you should be able to ask for a review")
    }

    
    func testAppIsInvalidForRequestOnFreshLaunch() {
        
        for _ in 0..<manager.limit - 1 {
            manager.increase()
        }
        
        XCTAssertFalse(manager.canAskForReview(), "The limit(\(manager.limit)) hasn't been reached you should not be able to ask for a review")
    }
    
    func testAppIsInvalidForRequestAfterLimitReached() {
        
        let oldVersion = "1.0"
        let newVersion = "1.1"
        
        func simluateIncrease() {
            for _ in 0..<manager.limit {
                manager.increase()
            }
        }
        
        simluateIncrease()
        
        XCTAssertTrue(manager.canAskForReview(lastReviewedVersion: nil,
                                            currentVersion: oldVersion),
                      "The limit(\(manager.limit)) has been reached you should be able to ask for a review \(oldVersion)")

        simluateIncrease()
        
        XCTAssertTrue(manager.canAskForReview(lastReviewedVersion: oldVersion,
                                             currentVersion: newVersion),
                      "The limit(\(manager.limit)) has been reached you should be able to ask for a review \(newVersion)")

    }
    
    func testAppIsValidForRequestForNewVersion() {
       
        let oldVersion = "1.0"
        let newVersion = "1.1"

        for _ in 0..<manager.limit {
            manager.increase()
        }
        
        XCTAssertTrue(manager.canAskForReview(lastReviewedVersion: nil,
                                            currentVersion: oldVersion),
                      "The limit(\(manager.limit)) has been reached you should be able to ask for a review \(oldVersion)")

        manager.increase()
        
        XCTAssertFalse(manager.canAskForReview(lastReviewedVersion: oldVersion,
                                             currentVersion: newVersion),
                      "The limit(\(manager.limit)) hasn't been reached you should not be able to ask for a review \(newVersion)")

    }
}
