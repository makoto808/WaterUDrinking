//
//  SubscribeVM.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/7/25.
//

import StoreKit

@MainActor
class SubscribeVM: ObservableObject {
    @Published var oneTimeProduct: Product?
    @Published var subscriptionProduct: Product?

    @Published var oneTimePurchased = false
    @Published var subscriptionPurchased = false

    let oneTimeProductID = "com.greggyphenom.waterudrinking.prounlock"
    let subscriptionProductID = "com.greggyphenom.waterudrinking.subscription1" // update with your actual subscription ID

    init() {
        Task {
            await loadProducts()
            await checkPurchases()
        }
    }

    func loadProducts() async {
        do {
            let products = try await Product.products(for: [oneTimeProductID, subscriptionProductID])
            oneTimeProduct = products.first(where: { $0.id == oneTimeProductID })
            subscriptionProduct = products.first(where: { $0.id == subscriptionProductID })
        } catch {
            print("Failed to load products: \(error)")
        }
    }

    func purchase(_ product: Product) async {
        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                if case .verified(let transaction) = verification {
                    if transaction.productID == oneTimeProductID {
                        oneTimePurchased = true
                    } else if transaction.productID == subscriptionProductID {
                        subscriptionPurchased = true
                    }
                    await transaction.finish()
                }
            case .userCancelled:
                print("User cancelled")
            case .pending:
                print("Purchase pending")
            @unknown default:
                break
            }
        } catch {
            print("Purchase failed: \(error)")
        }
    }

    func checkPurchases() async {
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result {
                if transaction.productID == oneTimeProductID {
                    oneTimePurchased = true
                } else if transaction.productID == subscriptionProductID {
                    subscriptionPurchased = true
                }
            }
        }
    }
}
