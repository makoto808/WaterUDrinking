//
//  SettingsReviewView.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/2/25.
//

import StoreKit
import SwiftUI

struct SettingsReviewView: View {
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        Button("Give us a review!") {
            requestReview()
        }
    }
}

#Preview {
    SettingsReviewView()
}
