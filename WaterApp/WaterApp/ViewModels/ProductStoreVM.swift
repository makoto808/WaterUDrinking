//
//  ProductStoreVM.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/7/25.
//

import StoreKit

@MainActor
class ProductStore: ObservableObject {
    @Published var product: Product?
    @Published var purchased = false
    
    let productID = "com.greggyphenom.waterudrinking.prounlock"
    
    init() {
        Task {
            await loadProduct()
            await checkPurchaseStatus()
        }
    }
    
    func loadProduct() async {
        do {
            let products = try await Product.products(for: [productID])
            product = products.first
        } catch {
            print("Failed to load product: \(error)")
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
                break
            case .pending:
                break
            @unknown default:
                break
            }
        } catch {
            print("Purchase failed: \(error)")
        }
    }
    
    func checkPurchaseStatus() async {
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result,
               transaction.productID == productID {
                purchased = true
            }
        }
    }
}
