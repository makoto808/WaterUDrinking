//
//  PurchaseOptionsSection.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/15/25.
//

import ConfettiSwiftUI
import StoreKit
import SwiftUI

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
                
                // NOTE: User has subscription but no lifetime unlock
                VStack(spacing: 16) {
                    PurchasedView(
                        ownsLifetimeUnlock: false,
                        currentSubscription: current,
                        confettiCounter: $confettiCounter
                    )
                    
                    Divider()
                    
                    // NOTE: No lifetimeUnlockSection here to avoid duplication
                }
            } else {
                // NOTE: No subscription and no lifetime unlock: show all purchase options + lifetime unlock
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
                    
                    Divider()
                }
            }
        }
        .background(Color("AppBackgroundColor"))
    }
}
