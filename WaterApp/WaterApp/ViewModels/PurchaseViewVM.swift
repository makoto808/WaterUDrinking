//
//  PurchaseViewVM.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/15/25.
//

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
    var isLoading = false {
        didSet { print("isLoading: \(isLoading)") }
    }
    var isPurchased = false {
        didSet { print("isPurchased: \(isPurchased)") }
    }
    var isPurchasing = false {
        didSet { print("isPurchasing: \(isPurchasing)") }
    }
    var showNoPurchasesFoundAlert = false
    var showRestoreErrorAlert = false
    var ownsLifetimeUnlock = false {
        didSet { print("ownsLifetimeUnlock: \(ownsLifetimeUnlock)") }
    }
    
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
            
            // Update ownership state after verification
            await checkOwnedProducts()
            await checkCurrentSubscription()
            
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
            print("Loaded products: annual=\(annualProduct?.id ?? "nil"), monthly=\(monthlyProduct?.id ?? "nil"), oneTime=\(oneTimeProduct?.id ?? "nil")")
        } catch {
            print("❌ Product loading failed: \(error.localizedDescription)")
        }
    }
    
    func checkCurrentSubscription() async {
        currentSubscription = nil
        isPurchased = false

        // 💡 If they own the lifetime unlock, skip subscription check
        if ownsLifetimeUnlock {
            print("ℹ️ Skipping subscription check because user owns lifetime unlock.")
            return
        }

        let subscriptions = [monthlyProduct, annualProduct].compactMap { $0 }

        for product in subscriptions {
            do {
                let statuses = try await product.subscription?.status ?? []

                for status in statuses {
                    if status.state == .subscribed {
                        currentSubscription = product
                        isPurchased = true
                        print("✅ Active subscription found: \(product.displayName)")
                        return
                    }
                }

            } catch {
                print("❌ Failed to check status for \(product.id): \(error.localizedDescription)")
            }
        }

        print("No active subscription found")
    }


    func purchase(_ product: Product) async {
        guard !isPurchasing else { return }
        isPurchasing = true
        defer { isPurchasing = false }
        
        do {
            let result = try await product.purchase()
            switch result {
            case .success(.verified(let transaction)):
                await transaction.finish()
                print("✅ Purchase verified for: \(product.displayName)")
                // Small delay to let StoreKit update receipts
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                await checkOwnedProducts()
                await checkCurrentSubscription()
                
                
            case .success(.unverified(let transaction, let error)):
                print("⚠️ Purchase unverified: \(error.localizedDescription)")
                await transaction.finish()
                
            case .userCancelled:
                print("❌ Purchase cancelled by user")
                
            default:
                break
            }
        } catch {
            print("❌ Error purchasing: \(error)")
        }
    }
    
    func refreshSubscriptions() async {
        isLoading = true
        defer { isLoading = false }

        do {
            try await AppStore.sync()
        } catch {
            print("Receipt refresh failed: \(error.localizedDescription)")
        }

        try? await Task.sleep(nanoseconds: 1_000_000_000)

        await checkCurrentSubscription()
        await checkOwnedProducts()
    }
    
    func restorePurchases() async {
        do {
            try await AppStore.sync()
        } catch {
            showRestoreErrorAlert = true
            print("Restore purchases failed: \(error.localizedDescription)")
            return
        }

        var hasEntitlements = false
        var foundSubscription: Product? = nil
        var foundLifetimeUnlock = false

        let allProducts = [oneTimeProduct, monthlyProduct, annualProduct].compactMap { $0 }

        for await verificationResult in Transaction.currentEntitlements {
            switch verificationResult {
            case .unverified(_, let error):
                print("Unverified entitlement during restore: \(error.localizedDescription)")
                continue
            case .verified(let entitlement):
                hasEntitlements = true
                let productID = entitlement.productID

                if let matchedProduct = allProducts.first(where: { $0.id == productID }) {
                    print("✅ Restored product: \(matchedProduct.displayName)")

                    if matchedProduct.type == .nonConsumable && matchedProduct.id == oneTimeProduct?.id {
                        foundLifetimeUnlock = true
                    }
                    if matchedProduct.type == .autoRenewable {
                        foundSubscription = matchedProduct
                    }
                }
            }
        }

        ownsLifetimeUnlock = foundLifetimeUnlock
        currentSubscription = foundSubscription
        print("After restore - ownsLifetimeUnlock: \(ownsLifetimeUnlock), currentSubscription: \(currentSubscription?.id ?? "none")")

        if !hasEntitlements {
            showNoPurchasesFoundAlert = true
            print("No purchases found during restore")
            return
        }

        try? await Task.sleep(nanoseconds: 1_000_000_000)

        await checkCurrentSubscription()
        await checkOwnedProducts()
    }
    
    func checkOwnedProducts() async {
        ownsLifetimeUnlock = false

        let lifetimeProductID = oneTimeProduct?.id

        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else {
                if case .unverified(_, let error) = result {
                    print("⚠️ Unverified entitlement: \(error.localizedDescription)")
                }
                continue
            }

            print("Checking transaction productID: \(transaction.productID)")

            if transaction.productID == lifetimeProductID {
                ownsLifetimeUnlock = true
                isPurchased = true
                print("✅ Owns lifetime unlock")
            }
        }

        print("ownsLifetimeUnlock final value: \(ownsLifetimeUnlock)")
    }

    
    func refreshOwnership() async {
        var ownsLifetime = false
        var foundSubscription: Product? = nil
        
        // Check lifetime unlock ownership
        for await result in Transaction.currentEntitlements {
            switch result {
            case .verified(let transaction):
                print("Checking transaction productID: \(transaction.productID)")
                if let product = oneTimeProduct, transaction.productID == product.id, product.type == .nonConsumable {
                    ownsLifetime = true
                    print("✅ Owns lifetime unlock")
                }
            case .unverified(_, let error):
                print("⚠️ Unverified entitlement: \(error.localizedDescription)")
            }
        }
        
        // If lifetime not owned, check subscriptions
        if !ownsLifetime {
            let products = [monthlyProduct, annualProduct].compactMap { $0 }
            for product in products {
                do {
                    let statuses = try await product.subscription?.status ?? []
                    for status in statuses {
                        if status.state == .subscribed {
                            foundSubscription = product
                            print("✅ Subscribed to: \(product.displayName)")
                            break
                        }
                    }
                } catch {
                    print("❌ Failed to check subscription status for \(product.id): \(error.localizedDescription)")
                }
                if foundSubscription != nil { break }
            }
        }
        
        // Update UI state atomically on main actor
        await MainActor.run {
            self.ownsLifetimeUnlock = ownsLifetime
            self.currentSubscription = ownsLifetime ? nil : foundSubscription
            self.isPurchased = ownsLifetime || (foundSubscription != nil)
        }
    }

    
}
