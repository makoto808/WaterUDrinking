//
//  OneTimePurchaseStore.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/7/25.
//

import StoreKit

@MainActor
class OneTimePurchaseStore: ObservableObject {
    @Published var product: Product?
    @Published var purchased = false
    
    private let productID = "com.greggyphenom.waterudrinking.prounlock"
    
    init() {
        Task {
            await loadProduct()
            await checkIfPurchased()
        }
    }
    
    func loadProduct() async {
        do {
            let products = try await Product.products(for: [productID])
            product = products.first
        } catch {
            print("Error loading product: \(error)")
        }
    }
    
    func purchase() async {
        guard let product = product else { return }
        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                if case .verified(let transaction) = verification {
                    purchased = true
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
    
    func checkIfPurchased() async {
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result,
               transaction.productID == productID {
                purchased = true
            }
        }
    }
}
