//
//  PurchasedView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/16/25.
//

import ConfettiSwiftUI
import StoreKit
import SwiftUI

struct PurchasedView: View {
    @State private var hasFiredConfetti = false

    @Binding var confettiCounter: Int
    
    let ownsLifetimeUnlock: Bool
    let currentSubscription: Product?
    
    var body: some View {
        VStack(spacing: 16) {
            if ownsLifetimeUnlock || currentSubscription != nil {
                VStack(spacing: 8) {
                    Text("🎉 Cheers to More Hydration 🎉")
                        .fontThankYouTitle()
                    Text("Thanks for the Support!")
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
                        .font(.custom("ArialRoundedMTBold", size: 18))
                        .fontWeight(.semibold)
                        .padding(.top, 8)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("PurchaseRowBackground"))
                .cornerRadius(12)
                .padding(.horizontal)
                .onAppear {
                    guard !hasFiredConfetti else { return }
                    hasFiredConfetti = true

                    if ownsLifetimeUnlock {
                        fireConfetti(repeat: 10) // 🎉 15 bursts for lifetime
                    } else {
                        confettiCounter += 1    // 🎉 1 burst for subscription
                    }
                }
            }
        }
    }
    
    private func fireConfetti(repeat count: Int) {
        Task {
            for _ in 0..<count {
                confettiCounter += 1
                let randomDelay = Double.random(in: 2...5)
                try? await Task.sleep(nanoseconds: UInt64(randomDelay * 1_000_000_000))
            }
        }
    }
}
