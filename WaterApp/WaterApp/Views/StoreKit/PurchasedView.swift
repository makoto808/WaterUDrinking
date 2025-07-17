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
    @Binding var confettiCounter: Int
    
    var body: some View {
        VStack(spacing: 16) {
            if ownsLifetimeUnlock || currentSubscription != nil {
                VStack(spacing: 8) {
                    Text("🎉 Thanks for unlocking premium features!")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    
                    if ownsLifetimeUnlock {
                        Text("✅ Lifetime Access Unlocked")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.accentColor)
                    } else if let sub = currentSubscription {
                        Text("✅ Subscribed to: \(sub.displayName)")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.accentColor)
                        
                        Button("Manage Subscription") {
                            if let url = URL(string: "https://apps.apple.com/account/subscriptions") {
                                UIApplication.shared.open(url)
                            }
                        }
                        .font(.subheadline)
                        .padding(.top, 8)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.15))
                .cornerRadius(12)
                .padding(.horizontal)
                .onAppear {
                    confettiCounter += 1
                }
            }
        }
        .confettiCannon(
            trigger: $confettiCounter,
            num: 50,
            rainHeight: 400,
            openingAngle: Angle(degrees: 45),
            closingAngle: Angle(degrees: 135),
            radius: 300
        )
    }
}
