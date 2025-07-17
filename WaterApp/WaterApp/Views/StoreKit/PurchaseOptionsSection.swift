//
//  PurchaseOptionsSection.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/15/25.
//

import SwiftUI
import StoreKit
import ConfettiSwiftUI

struct PurchaseOptionsSection: View {
    @Bindable var viewModel: PurchaseViewVM
    @Binding var confettiCounter: Int
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                LoadingView()
            } else if viewModel.ownsLifetimeUnlock {
                PurchasedView(
                    ownsLifetimeUnlock: true,
                    currentSubscription: viewModel.currentSubscription,
                    confettiCounter: $confettiCounter
                )
            } else if let current = viewModel.currentSubscription {
                // User has subscription but no lifetime unlock
                VStack(spacing: 16) {
                    PurchasedView(
                        ownsLifetimeUnlock: false,
                        currentSubscription: current,
                        confettiCounter: $confettiCounter
                    )
                    // No lifetimeUnlockSection here to avoid duplication
                }
            } else {
                // No subscription and no lifetime unlock: show all purchase options + lifetime unlock
                VStack(spacing: 16) {
                    PurchaseOptionsView(
                        ownsLifetimeUnlock: false,
                        currentSubscription: nil,
                        monthlyProduct: viewModel.monthlyProduct,
                        annualProduct: viewModel.annualProduct,
                        oneTimeProduct: viewModel.oneTimeProduct,
                        isPurchasing: viewModel.isPurchasing,
                        purchaseAction: viewModel.purchase,
                        checkOwnedProductsAction: viewModel.checkOwnedProducts
                    )
                    
                    if let oneTime = viewModel.oneTimeProduct {
                        Divider()
                        lifetimeUnlockSection(oneTime)
                    }
                }
            }
        }
        .background(Color("AppBackgroundColor"))
    }
    
    @ViewBuilder
    private func lifetimeUnlockSection(_ oneTime: Product) -> some View {
        VStack(spacing: 10) {
            Button {
                Task {
                    await viewModel.purchase(oneTime)
                }
            } label: {
                HStack {
                    Text("Upgrade to Lifetime Access")
                        .fontWeight(.semibold)
                    Spacer()
                    Text(oneTime.displayPrice)
                }
                .padding()
                .background(Color.blue.opacity(0.15))
                .cornerRadius(12)
            }
            
            Text("One-time unlock: Pay once, use forever — no recurring fees.")
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    PurchaseOptionsSection(viewModel: PurchaseViewVM())
//}
