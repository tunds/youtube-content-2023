//
//  ReviewsRequestManager.swift
//  AppReviewAndRatings
//
//  Created by Tunde Adegoroye on 22/01/2023.
//

import Foundation

final class ReviewsRequestManager: ObservableObject {
    
    @Published private(set) var count: Int
    
    private let userDefaults: UserDefaults
    private(set) var reviewLink = URL(string: "https://apps.apple.com/app/id6444908091?action=write-review")
    
    let limit = 30
    let reviewCountKey = "com.tundsdev.AppReviewAndRatings.reviewCount"
    let lastReviewedVersionKey = "com.tundsdev.AppReviewAndRatings.lastReviewedVersion"
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        self.count = userDefaults.integer(forKey: reviewCountKey)
    }
    
    func canAskForReview(
        lastReviewedVersion: String? = nil,
        currentVersion: String? = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String) -> Bool {
        
        let recentReviewedVersion = lastReviewedVersion ?? userDefaults.string(forKey: lastReviewedVersionKey)
        
        guard let currentVersion = currentVersion else { fatalError("Expected to find a bundle version in the info dictionary.") }
        
        guard userDefaults.integer(forKey: reviewCountKey).isMultiple(of: limit) && currentVersion != recentReviewedVersion else {
            return false
        }
        
        userDefaults.set(currentVersion, forKey: lastReviewedVersionKey)
        return true
    }
    
    func increase() {
        count += 1
        userDefaults.set(count, forKey: reviewCountKey)
    }
}
