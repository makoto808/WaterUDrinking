//
//  SubscribedView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/16/25.
//

import SwiftUI
import StoreKit

struct SubscribedView: View {
    let currentSubscription: Product
    @Bindable var viewModel: PurchaseViewVM
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Thanks for being a subscriber! Unlock Pro features forever with a one-time purchase!")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
            
            VStack(spacing: 12) {
                if currentSubscription.type == .autoRenewable {
                    AutoRenewableSubscriptionView(current: currentSubscription, viewModel: viewModel)
                } else {
                    NonRenewingSubscriptionView(current: currentSubscription)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.accentColor.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

struct AutoRenewableSubscriptionView: View {
    let current: Product
    @Bindable var viewModel: PurchaseViewVM
    
    var body: some View {
        VStack(spacing: 8) {
            Text("You're subscribed to the:")
                .font(.headline)
            Text(current.displayName)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.accentColor)
            
            Text(current.displayPrice)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Button("Manage Subscription") {
                if let url = URL(string: "https://apps.apple.com/account/subscriptions") {
                    UIApplication.shared.open(url)
                }
            }
            .font(.subheadline)
            .padding(.top, 8)
            
            if let oneTime = viewModel.oneTimeProduct, !viewModel.ownsLifetimeUnlock {
                Divider().padding(.vertical)
                
                VStack(spacing: 8) {
                    PurchaseRow(
                        title: "Upgrade to Lifetime Access",
                        description: oneTime.displayPrice
                    ) {
                        Task {
                            await viewModel.purchase(oneTime)
                            await viewModel.checkOwnedProducts()
                        }
                    }
                    Text("One-time unlock: Pay once, use forever — no recurring fees.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct NonRenewingSubscriptionView: View {
    let current: Product
    
    var body: some View {
        VStack(spacing: 8) {
            Text("You've unlocked Pro for life 🎉")
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Text(current.displayName)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.accentColor)
            
            Text(current.displayPrice)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

//#Preview {
//    SubscribedView()
//}
