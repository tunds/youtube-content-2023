//
//  ContentView.swift
//  AppReviewAndRatings
//
//  Created by Tunde Adegoroye on 22/01/2023.
//

import SwiftUI
import StoreKit

struct ContentView: View {
    
    @Environment(\.requestReview) var requestReview: RequestReviewAction
    @Environment(\.openURL) var openURL
    @EnvironmentObject private var requestReviewManager: ReviewsRequestManager
    
    var body: some View {
        VStack {
            Text("\(requestReviewManager.count)")
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
            Button {
                
                requestReviewManager.increase()
                
                if requestReviewManager.canAskForReview() {
                    requestReview()
                }
                
            } label: {
                Text("Increase")
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            
            Button {
               
                if let link = requestReviewManager.reviewLink {
                    openURL(link)
                }
                
            } label: {
                Text("Leave Review")
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ReviewsRequestManager())
    }
}
