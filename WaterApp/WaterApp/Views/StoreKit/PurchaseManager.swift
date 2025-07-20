//
//  PurchaseManager.swift
//  WaterApp
//

import Combine
import StoreKit

@MainActor
final class PurchaseManager: ObservableObject {
    @Published var hasProAccess = false

    static let shared = PurchaseManager()
    
    private let proProductIDs: Set<String> = [
        "com.greggyphenom.waterudrinking.prounlock",   // lifetime
        "com.greggyphenom.waterudrinking.monthly2",    // monthly
        "com.greggyphenom.waterudrinking.annual"       // yearly
    ]

    private init() {}

    func updatePurchaseStatus() async {
        var hasActiveEntitlement = false

        print("🔍 Checking current entitlements...")
        print("Current device date: \(Date())")

        for await result in Transaction.currentEntitlements {
            switch result {
            case .verified(let transaction):
                print("✅ Verified transaction: \(transaction.productID), expires: \(transaction.expirationDate?.description ?? "never")")
                
                print("Checking conditions:")
                print("- productID in proProductIDs: \(proProductIDs.contains(transaction.productID))")
                print("- revocationDate == nil: \(transaction.revocationDate == nil)")
                
                if let expiration = transaction.expirationDate {
                    print("- expirationDate == nil: false")
                    print("- expirationDate > Date(): \(expiration > Date())")
                } else {
                    print("- expirationDate == nil: true")
                }
                
                if proProductIDs.contains(transaction.productID),
                   transaction.revocationDate == nil,
                   (transaction.expirationDate == nil || transaction.expirationDate! > Date()) {
                    hasActiveEntitlement = true
                    print("🎉 Active pro entitlement found: \(transaction.productID)")
                } else {
                    print("❌ Transaction not valid or expired")
                }

            case .unverified(_, let error):
                print("❌ Unverified transaction error: \(error.localizedDescription)")
            }
        }

        hasProAccess = hasActiveEntitlement
        print("🔑 hasProAccess set to: \(hasProAccess)")
    }

    func listenForUpdates() {
        Task {
            for await _ in Transaction.updates {
                await updatePurchaseStatus()
            }
        }
    }
} 
