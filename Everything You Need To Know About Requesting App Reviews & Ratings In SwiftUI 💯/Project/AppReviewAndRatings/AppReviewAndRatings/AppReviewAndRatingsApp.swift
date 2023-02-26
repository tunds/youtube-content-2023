//
//  AppReviewAndRatingsApp.swift
//  AppReviewAndRatings
//
//  Created by Tunde Adegoroye on 22/01/2023.
//

import SwiftUI

@main
struct AppReviewAndRatingsApp: App {
    
    @StateObject private var reviewRatingsManager = ReviewsRequestManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(reviewRatingsManager)
        }
    }
}
