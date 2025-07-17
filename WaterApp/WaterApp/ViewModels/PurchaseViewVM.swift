//
//  PurchaseViewVM.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/15/25.
//

import Foundation
import StoreKit
import SwiftUI

@MainActor
@Observable final class PurchaseViewVM {
    var oneTimeProduct: Product?
    var monthlyProduct: Product?
    var annualProduct: Product?
    var currentSubscription: Product?
    
    var showingSignIn = false
    var isLoading = false
    var isPurchased = false
    var showNoPurchasesFoundAlert = false
    var showRestoreErrorAlert = false
    var ownsLifetimeUnlock = false
    
    let productIDs = [
        "com.greggyphenom.waterudrinking.annual",
        "com.greggyphenom.waterudrinking.monthly2",
        "com.greggyphenom.waterudrinking.prounlock"
    ]
    
    init() {
        Task {
            for await verificationResult in StoreKit.Transaction.updates {
                await handle(transactionVerificationResult: verificationResult)
            }
        }
    }
    
    @MainActor
    private func handle(transactionVerificationResult: VerificationResult<StoreKit.Transaction>) async {
        switch transactionVerificationResult {
        case .unverified(_, let error):
            print("Transaction unverified: \(error.localizedDescription)")
        case .verified(let transaction):
            print("Transaction verified: \(transaction.productID)")
            isPurchased = true
            await transaction.finish()
        }
    }
    
    func loadProducts() async {
        isLoading = true
        defer { isLoading = false }
        
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
        } catch {
            print("❌ Product loading failed: \(error.localizedDescription)")
        }
    }
    
    func checkCurrentSubscription() async {
        for await verificationResult in Transaction.currentEntitlements {
            switch verificationResult {
            case .unverified(_, let error):
                print("Unverified entitlement: \(error.localizedDescription)")
                continue
            case .verified(let entitlement):
                guard entitlement.revocationDate == nil,
                      entitlement.expirationDate ?? .distantFuture > Date()
                else { continue }

                let productID = entitlement.productID
                let allProducts = [oneTimeProduct, monthlyProduct, annualProduct].compactMap { $0 }

                if let matchedProduct = allProducts.first(where: { $0.id == productID }) {
                    currentSubscription = matchedProduct
                    print("✅ Subscribed to: \(matchedProduct.displayName)")
                    return
                }
            }
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
    
    func restorePurchases() {
        Task {
            do {
                try await AppStore.sync()
            } catch {
                showRestoreErrorAlert = true
                return
            }

            var hasEntitlements = false
            for await verificationResult in Transaction.currentEntitlements {
                switch verificationResult {
                case .unverified(_, let error):
                    print("Unverified entitlement during restore: \(error.localizedDescription)")
                    continue
                case .verified(let entitlement):
                    hasEntitlements = true
                    let productID = entitlement.productID
                    let allProducts = [oneTimeProduct, monthlyProduct, annualProduct].compactMap { $0 }

                    if let matchedProduct = allProducts.first(where: { $0.id == productID }) {
                        currentSubscription = matchedProduct
                        print("✅ Restored subscription: \(matchedProduct.displayName)")
                    }

                    break
                }
            }

            if !hasEntitlements {
                showNoPurchasesFoundAlert = true
            }
        }
    }

    private func checkIfPurchasesExist() async -> Bool {
        for await _ in Transaction.currentEntitlements {
            return true
        }
        return false
    }
    
    func checkOwnedProducts() async {
           for await result in Transaction.currentEntitlements {
               guard case .verified(let transaction) = result else { continue }

               if transaction.productID == oneTimeProduct?.id {
                   ownsLifetimeUnlock = true
                   print("✅ Owns lifetime unlock")
               }
           }
       }
}
