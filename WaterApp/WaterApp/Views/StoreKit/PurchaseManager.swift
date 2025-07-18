//
//  PurchaseManager.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/16/25.
//

import StoreKit

@MainActor
final class PurchaseManager: ObservableObject {
    @Published var isPurchased = false

    static let shared = PurchaseManager() // for easy global access

    private init() {}

    func updatePurchaseStatus() async {
        for await result in Transaction.currentEntitlements {
            switch result {
            case .verified(let transaction):
                print("✅ Verified Transaction: \(transaction.productID)")
                print("Purchase date: \(transaction.purchaseDate)")
                print("Revocation date: \(String(describing: transaction.revocationDate))")

                if transaction.productID == "com.greggyphenom.waterudrinking.prounlock",
                   transaction.revocationDate == nil,
                   transaction.expirationDate == nil {
                    isPurchased = true
                    return
                }

            case .unverified(_, let error):
                print("❌ Unverified: \(error)")
            }
        }
        isPurchased = false
    }

    func listenForUpdates() {
        Task {
            for await _ in Transaction.updates {
                await updatePurchaseStatus()
            }
        }
    }
}
