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
    @State private var hasShownConfetti = false

    var body: some View {
        VStack(spacing: 16) {
            if ownsLifetimeUnlock || currentSubscription != nil {
                VStack(spacing: 8) {
                    Text("🎉 Thanks for subscribing! Enjoy your premium features.")
                        .font(.headline)
                        .multilineTextAlignment(.center)

                    if let sub = currentSubscription {
                        Text("Subscribed to: \(sub.displayName)")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.accentColor)
                    } else {
                        Text("Lifetime Access")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.accentColor)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.15))
                .cornerRadius(12)
                .padding(.horizontal)
                .onAppear {
                    if !hasShownConfetti {
                        confettiCounter += 1
                        hasShownConfetti = true
                    }
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
