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
    
    @State private var showFAQ = false
    @State private var showConfetti = false
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView("Loading Products...")
                .progressViewStyle(CircularProgressViewStyle())
                .padding()
        } else if viewModel.isPurchased {
            // 🎉 Success message with simple confetti animation
            VStack(spacing: 16) {
                if viewModel.ownsLifetimeUnlock {
                    Text("🎉 Congratulations! You’ve unlocked lifetime access.")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                } else if let sub = viewModel.currentSubscription {
                    Text("🎉 Thanks for subscribing! Enjoy your premium features.")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    Text("Subscribed to: \(sub.displayName)")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.accentColor)
                }
            }
            .padding()
            .onAppear {
                withAnimation {
                    showConfetti = true
                }
            }
            // TODO: Add actual confetti animation here if you want
        } else if let current = viewModel.currentSubscription {
            VStack(spacing: 16) {
                // Personalized message for subscribers
                Text("Thanks for being a subscriber! Unlock Pro features forever with a one-time purchase!")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)
                
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
                        
                        // Upgrade to lifetime unlock option
                        if let oneTime = viewModel.oneTimeProduct, !viewModel.ownsLifetimeUnlock {
                            Divider().padding(.vertical)
                            
                            VStack(spacing: 8) {
                                PurchaseRow(title: "Upgrade to Lifetime Access", description: oneTime.displayPrice) {
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
            }
        } else {
            VStack(spacing: 16) {
                // Personalized message for non-subscribers
                Text("Choose the best plan for you and enjoy premium features to help you stay hydrated!")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)
                
                // Info button for FAQ
                HStack {
                    Spacer()
                    Button {
                        showFAQ = true
                    } label: {
                        Image(systemName: "info.circle")
                            .font(.title3)
                    }
                    .padding(.bottom, 4)
                }
                
                if !viewModel.ownsLifetimeUnlock {
                    if let monthly = viewModel.monthlyProduct {
                        VStack(spacing: 4) {
                            PurchaseRow(title: "Pro Monthly Plan", description: monthly.displayPrice) {
                                Task { await viewModel.purchase(monthly) }
                            }
                            Text("Track unlimited days and get personalized insights.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    if let annual = viewModel.annualProduct {
                        VStack(spacing: 4) {
                            PurchaseRow(title: "Pro Annual Plan", description: annual.displayPrice) {
                                Task { await viewModel.purchase(annual) }
                            }
                            Text("Save 20% annually and never worry about monthly payments.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                if let oneTime = viewModel.oneTimeProduct, !viewModel.ownsLifetimeUnlock {
                    VStack(spacing: 4) {
                        PurchaseRow(title: "Pro One-Time Unlock", description: oneTime.displayPrice) {
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
            .background(Color("AppBackgroundColor"))
            .alert("Subscription & Lifetime Unlock FAQ", isPresented: $showFAQ) {
                Button("Close", role: .cancel) { }
            } message: {
                Text("""
                • Subscription gives you access while active; billed monthly or annually.

                • Lifetime Unlock is a one-time purchase with permanent access.

                • You can manage or cancel your subscription anytime in your Apple ID settings.
                """)
            }
        }
    }
}

#Preview {
    PurchaseOptionsSection(viewModel: PurchaseViewVM())
}
