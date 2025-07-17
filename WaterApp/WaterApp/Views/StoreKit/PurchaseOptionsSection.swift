//
//  PurchaseOptionsSection.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/15/25.
//

import SwiftUI
import StoreKit

struct PurchaseOptionsSection: View {
    @Bindable var viewModel: PurchaseViewVM

    var body: some View {
        if viewModel.isLoading {
            ProgressView("Loading Products...")
                .progressViewStyle(CircularProgressViewStyle())
                .padding()
        } else if let current = viewModel.currentSubscription {
            VStack(spacing: 12) {
                if current.type == .autoRenewable {
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

                    // Offer upgrade to lifetime if not owned
                    if let oneTime = viewModel.oneTimeProduct, !viewModel.ownsLifetimeUnlock {
                        Divider().padding(.vertical)
                        PurchaseRow(title: "Upgrade to Lifetime Access", description: oneTime.displayPrice) {
                            Task {
                                await viewModel.purchase(oneTime)
                                await viewModel.checkOwnedProducts()
                            }
                        }
                    }
                } else {
                    // Lifetime unlock message
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
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.accentColor.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        } else {
            VStack(spacing: 16) {
                // Show subscriptions only if lifetime not unlocked
                if !viewModel.ownsLifetimeUnlock {
                    if let monthly = viewModel.monthlyProduct {
                        PurchaseRow(title: "Pro Monthly Plan", description: monthly.displayPrice) {
                            Task { await viewModel.purchase(monthly) }
                        }
                    }

                    if let annual = viewModel.annualProduct {
                        PurchaseRow(title: "Pro Annual Plan", description: annual.displayPrice) {
                            Task { await viewModel.purchase(annual) }
                        }
                    }
                }

                // Show lifetime unlock if not owned
                if let oneTime = viewModel.oneTimeProduct, !viewModel.ownsLifetimeUnlock {
                    PurchaseRow(title: "Pro One-Time Unlock", description: oneTime.displayPrice) {
                        Task {
                            await viewModel.purchase(oneTime)
                            await viewModel.checkOwnedProducts()
                        }
                    }
                }
            }
            .background(Color("AppBackgroundColor"))
        }
    }
}

#Preview {
    PurchaseOptionsSection(viewModel: PurchaseViewVM())
}
