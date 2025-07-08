//
//  SubscribeView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/3/25.
//

import SwiftUI

struct SubscribeView: View {
    @StateObject private var vm = SubscribeVM()
    var onUnlock: () -> Void

    var body: some View {
        VStack(spacing: 30) {
            if let oneTime = vm.oneTimeProduct {
                VStack(spacing: 8) {
                    Text(oneTime.displayName)
                        .font(.headline)
                    Text(oneTime.description)
                        .font(.subheadline)
                    Text(oneTime.displayPrice)
                        .font(.subheadline)
                    if vm.oneTimePurchased {
                        Text("Purchased ✅").foregroundColor(.green)
                    } else {
                        Button("Buy One-Time Unlock") {
                            Task {
                                await vm.purchase(oneTime)
                                if vm.oneTimePurchased {
                                    onUnlock()
                                }
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            }

            if let subscription = vm.subscriptionProduct {
                VStack(spacing: 8) {
                    Text(subscription.displayName)
                        .font(.headline)
                    Text(subscription.description)
                        .font(.subheadline)
                    Text(subscription.displayPrice)
                        .font(.subheadline)
                    if vm.subscriptionPurchased {
                        Text("Subscribed ✅").foregroundColor(.green)
                    } else {
                        Button("Subscribe") {
                            Task {
                                await vm.purchase(subscription)
                                if vm.subscriptionPurchased {
                                    onUnlock()
                                }
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            }

            if vm.oneTimeProduct == nil && vm.subscriptionProduct == nil {
                ProgressView("Loading products...")
            }
        }
        .padding()
        .navigationTitle("Subscribe or Unlock")
    }
}
