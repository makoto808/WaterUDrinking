//
//  PurchaseView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/9/25.
//

import StoreKit
import SwiftUI

struct PurchaseView: View {
    @State private var showingSignIn = false
    @State private var oneTimeProduct: Product?
    @State private var monthlyProduct: Product?
    @State private var annualProduct: Product?
    @State private var isPurchased = false

    let productIDs = [
        "com.greggyphenom.waterudrinking.annual",        // 0
        "com.greggyphenom.waterudrinking.monthly2",      // 1
        "com.greggyphenom.waterudrinking.prounlock"      // 2 ← one-time
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                Text("Upgrade to Pro")
                    .fontMediumTitle()

                VStack(spacing: 16) {
                    if let monthly = monthlyProduct {
                        subscriptionRow(title: "Pro Monthly Plan", description: "$1.99 / month") {
                            Task { await purchase(monthly) }
                        }
                    }

                    if let annual = annualProduct {
                        subscriptionRow(title: "Pro Annual Plan", description: "$14.99 / year") {
                            Task { await purchase(annual) }
                        }
                    }

                    if let oneTime = oneTimeProduct {
                        subscriptionRow(title: "Pro One-Time Unlock", description: oneTime.displayPrice) {
                            Task { await purchase(oneTime) }
                        }
                    }
                }

                if isPurchased {
                    Text("✅ Purchase successful!")
                        .foregroundColor(.green)
                }

                Divider()

                VStack(alignment: .leading, spacing: 8) {
                    Text("• Subscriptions auto-renew unless canceled at least 24 hours before the end of the current period.")
                    Text("• Payment will be charged to your Apple ID account at confirmation of purchase.")

                    Link("Privacy Policy", destination: URL(string: "https://makoto808.github.io/waterudrinking-support/privacy")!)
                    Link("Terms of Use (EULA)", destination: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
                        .padding(.top, 4)
                }
                .font(.footnote)
                .foregroundColor(.secondary)
            }
            .padding()
        }
        .task {
            await loadProducts()

            do {
                let subs = try await Product.products(for: [
                    "com.greggyphenom.waterudrinking.annual",
                    "com.greggyphenom.waterudrinking.monthly2"
                ])
                if subs.isEmpty {
                    print("⚠️ No subscriptions loaded — check product IDs and sandbox login.")
                } else {
                    print("✅ Loaded subs: \(subs.map(\.id))")
                }
            } catch {
                print("❌ Subscription loading failed: \(error.localizedDescription)")
            }
        }
        .sheet(isPresented: $showingSignIn) {
            Text("Custom sign-in view (optional)")
        }
    }

    func subscriptionRow(title: String, description: String, action: @escaping () -> Void) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(.headline)
                Text(description).font(.subheadline)
            }
            Spacer()
            Button("Purchase") {
                action()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
    }

    func loadProducts() async {
        do {
            let products = try await Product.products(for: productIDs)
            for product in products {
                switch product.id {
                case productIDs[0]: annualProduct = product
                case productIDs[1]: monthlyProduct = product
                case productIDs[2]: oneTimeProduct = product
                default: break
                }
            }

            if annualProduct == nil && monthlyProduct == nil {
                print("⚠️ No subscriptions loaded — check product IDs and sandbox account.")
            }
        } catch {
            print("❌ Product loading failed: \(error.localizedDescription)")
        }
    }

    func purchase(_ product: Product) async {
        do {
            let result = try await product.purchase()
            switch result {
            case .success(.verified(let transaction)):
                isPurchased = true
                print("Purchased: \(transaction.productID)")
                await transaction.finish()
            case .success(.unverified(_, let error)):
                print("Purchase failed verification: \(error.localizedDescription)")
            case .userCancelled:
                print("User cancelled purchase")
            case .pending:
                print("Purchase pending")
            @unknown default:
                break
            }
        } catch {
            print("Purchase failed: \(error.localizedDescription)")
        }
    }
}

#Preview {
    PurchaseView()
}
