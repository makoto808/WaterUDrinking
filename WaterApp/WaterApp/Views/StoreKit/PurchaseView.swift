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
    @State private var isPurchased = false
    
    let productIDs = [
        "com.greggyphenom.waterudrinking.annual",        // 0
        "com.greggyphenom.waterudrinking.monthly2",      // 1
        "com.greggyphenom.waterudrinking.prounlock"      // 2 ← needed for one-time
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Native subscription picker
                SubscriptionStoreView(productIDs: [productIDs[0], productIDs[1]])
                    .storeButton(.visible, for: .restorePurchases, .redeemCode, .signIn, .policies)
                    .subscriptionStorePolicyDestination(for: .privacyPolicy) {
                        Text("Your Privacy Policy Here")
                    }
                    .subscriptionStorePolicyDestination(for: .termsOfService) {
                        Text("Your Terms of Service Here")
                    }
                    .subscriptionStoreSignInAction {
                        showingSignIn = true
                    }
                    .subscriptionStoreControlStyle(.prominentPicker)
                    .frame(maxHeight: 500)
                
                Divider().padding(.horizontal)
                
                // One-time unlock
                if let product = oneTimeProduct {
                    VStack(spacing: 8) {
                        Text(product.displayName)
                            .font(.headline)
                        Text(product.description)
                            .font(.subheadline)
                        
                        Button("Unlock for \(product.displayPrice)") {
                            Task {
                                await purchase(product)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                
                if isPurchased {
                    Text("✅ One-time purchase successful!")
                        .foregroundColor(.green)
                }
            }
            .padding()
        }
        .task {
            await loadOneTimeProduct()

            do {
                let subs = try await Product.products(for: [
                    "com.greggyphenom.waterudrinking.annual",
                    "com.greggyphenom.waterudrinking.monthly2"
                ])
                print("✅ Loaded subs: \(subs.map(\.id))")
            } catch {
                print("❌ Subscription loading failed: \(error)")
            }
        }
        .sheet(isPresented: $showingSignIn) {
            Text("Custom sign-in view (optional)")
        }
        .navigationTitle("Upgrade to Pro")
    }
    
    func loadOneTimeProduct() async {
        do {
            let products = try await Product.products(for: [productIDs[2]])
            oneTimeProduct = products.first
        } catch {
            print("Error loading one-time product: \(error)")
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
