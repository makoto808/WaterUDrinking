//
//  PurchasedView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/16/25.
//

import SwiftUI
import StoreKit
import ConfettiSwiftUI

struct PurchasedView: View {
    let ownsLifetimeUnlock: Bool
    let currentSubscription: Product?
    
    @State private var hasFiredConfetti = false

    @Binding var confettiCounter: Int
    
    var body: some View {
        VStack(spacing: 16) {
            if ownsLifetimeUnlock || currentSubscription != nil {
                VStack(spacing: 8) {
                    Text("🎉 Cheers to More Hydration 🎉")
                        .fontThankYouTitle()
                    Text("Thanks For The Support!")
                        .fontThankYouTitle()
                    
                    if ownsLifetimeUnlock {
                        Text("Lifetime Access Unlocked")
                            .fontThankYouTitle2()
                    } else if let sub = currentSubscription {
                        Text("Subscribed to: \(sub.displayName)")
                            .fontProTitle()
                        
                        Button("Manage Subscription") {
                            if let url = URL(string: "https://apps.apple.com/account/subscriptions") {
                                UIApplication.shared.open(url)
                            }
                        }
                        .font(.custom("ArialRoundedMTBold", size: 14))
                        .padding(.top, 8)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("PurchaseRowBackground"))
                .cornerRadius(12)
                .padding(.horizontal)
                .onAppear {
                    if !hasFiredConfetti {
                        confettiCounter += 1
                        hasFiredConfetti = true
                    }
                }
            }
        }
    }
}
