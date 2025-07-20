//
//  PurchaseManager.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/16/25.
//

import StoreKit
import SwiftData

@Observable
@MainActor
final class PurchaseManager {
    var hasProAccess = false

    static let shared = PurchaseManager()
    
    private let proProductIDs: Set<String> = [
        "com.greggyphenom.waterudrinking.prounlock",               // lifetime
        "com.greggyphenom.waterudrinking.subscription.monthly",    // monthly
        "com.greggyphenom.waterudrinking.subscription.yearly"      // yearly
    ]

    private init() {}

    func updatePurchaseStatus() async {
        var hasActiveEntitlement = false

        for await result in Transaction.currentEntitlements {
            switch result {
            case .verified(let transaction):
                guard proProductIDs.contains(transaction.productID),
                      transaction.revocationDate == nil,
                      transaction.expirationDate == nil || transaction.expirationDate! > Date()
                else {
                    continue
                }

                print("✅ Active Pro Entitlement: \(transaction.productID)")
                hasActiveEntitlement = true

            case .unverified(_, let error):
                print("❌ Unverified transaction: \(error.localizedDescription)")
            }
        }

        hasProAccess = hasActiveEntitlement
    }

    func listenForUpdates() {
        Task {
            for await _ in Transaction.updates {
                await updatePurchaseStatus()
            }
        }
    }
}
