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
            if ownsLifetimeUnlock {
                // Only show this, even if sub exists
                lifetimeView
            } else if currentSubscription != nil {
                subscriptionView
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
    
    private var lifetimeView: some View {
        VStack {
            Text("🎉 Congratulations! You’ve unlocked lifetime access.")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color.blue.opacity(0.15))
        .cornerRadius(12)
        .padding(.horizontal)
        .onAppear {
            confettiCounter += 1
        }
    }

    private var subscriptionView: some View {
        VStack(spacing: 8) {
            Text("🎉 Thanks for subscribing! Enjoy your premium features.")
                .font(.headline)
                .multilineTextAlignment(.center)
            
            if let sub = currentSubscription {
                Text("Subscribed to: \(sub.displayName)")
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
            confettiCounter += 1
        }
    }

    struct PurchasedView_Previews: PreviewProvider {
        @State static var confettiCounter = 0
        
        static var previews: some View {
            PurchasedView(
                ownsLifetimeUnlock: true,
                currentSubscription: nil,
                confettiCounter: $confettiCounter
            )
            .previewDisplayName("Owns Lifetime Unlock")
            
            PurchasedView(
                ownsLifetimeUnlock: false,
                currentSubscription: nil, // or a mock Product if you create one
                confettiCounter: $confettiCounter
            )
            .previewDisplayName("No Lifetime Unlock")
        }
    }
}
