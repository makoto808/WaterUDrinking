//
//  OneTimePurchaseView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/7/25.
//

import SwiftUI

struct OneTimePurchaseView: View {
    @StateObject private var store = OneTimePurchaseStore()
    var onPurchaseSuccess: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            if let product = store.product {
                Text(product.displayName)
                    .font(.title)
                Text(product.description)
                    .font(.body)
                Text(product.displayPrice)
                    .font(.headline)

                if store.purchased {
                    Text("Thank you! Purchased ✅")
                        .foregroundColor(.green)
                        .onAppear {
                            onPurchaseSuccess()
                        }
                } else {
                    Button("Buy Now") {
                        Task {
                            await store.purchase()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            } else {
                Text("Loading product...")
            }
        }
        .padding()
    }
}

