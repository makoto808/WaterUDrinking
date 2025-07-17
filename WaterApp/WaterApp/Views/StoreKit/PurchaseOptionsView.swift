//
//  PurchaseOptionsView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/16/25.
//

import SwiftUI
import StoreKit

struct PurchaseOptionsView: View {
    let ownsLifetimeUnlock: Bool
    let currentSubscription: Product?
    let monthlyProduct: Product?
    let annualProduct: Product?
    let oneTimeProduct: Product?
    let isPurchasing: Bool
    let purchaseAction: (Product) async -> Void
    let checkOwnedProductsAction: () async -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Choose the best plan for you and enjoy premium features to help you stay hydrated!")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)
            
            if !ownsLifetimeUnlock {
                // Show Annual plan if not owned
                if let annual = annualProduct,
                   currentSubscription?.id != annual.id {
                    purchaseOption(
                        title: "Pro Annual Plan",
                        description: "Save 20% annually and never worry about monthly payments.",
                        price: annual.displayPrice,
                        product: annual
                    )
                }
                
                // Show Monthly plan if not owned AND annual is not owned (monthly hidden if annual owned)
                if let monthly = monthlyProduct,
                   currentSubscription?.id != monthly.id,
                   currentSubscription?.id != annualProduct?.id {
                    purchaseOption(
                        title: "Pro Monthly Plan",
                        description: "Track unlimited days and get personalized insights.",
                        price: monthly.displayPrice,
                        product: monthly
                    )
                }
            }
            
            // Show one-time lifetime unlock option if not owned
            if let oneTime = oneTimeProduct, !ownsLifetimeUnlock {
                purchaseOption(
                    title: "Pro One-Time Unlock",
                    description: "One-time unlock: Pay once, use forever — no recurring fees.",
                    price: oneTime.displayPrice,
                    product: oneTime
                )
            }
        }
    }
    
    @ViewBuilder
    private func purchaseOption(title: String, description: String, price: String, product: Product) -> some View {
        VStack(spacing: 4) {
            PurchaseRow(
                title: title,
                description: price,
                action: {
                    Task {
                        await purchaseAction(product)
                        await checkOwnedProductsAction()
                    }
                },
                isLoading: isPurchasing
            )
            Text(description)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

//#Preview {
//    PurchaseOptionsView(
//        ownsLifetimeUnlock: false,
//        monthlyProduct: nil,
//        annualProduct: nil,
//        oneTimeProduct: nil,
//        isPurchasing: false,
//        purchaseAction: { _ in },
//        checkOwnedProductsAction: {}
//    )
//}
