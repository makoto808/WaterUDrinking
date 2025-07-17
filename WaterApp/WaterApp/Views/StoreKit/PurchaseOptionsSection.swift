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
    
    @State private var confettiCounter = 0
    @State private var showFAQ = false
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                LoadingView()
            } else if viewModel.isPurchased {
                PurchasedView(
                    ownsLifetimeUnlock: viewModel.ownsLifetimeUnlock,
                    currentSubscription: viewModel.currentSubscription,
                    confettiCounter: $confettiCounter
                )
            } else if let current = viewModel.currentSubscription {
                SubscribedView(currentSubscription: current, viewModel: viewModel)
            } else {
                PurchaseOptionsView(
                    ownsLifetimeUnlock: viewModel.ownsLifetimeUnlock,
                    monthlyProduct: viewModel.monthlyProduct,
                    annualProduct: viewModel.annualProduct,
                    oneTimeProduct: viewModel.oneTimeProduct,
                    isPurchasing: viewModel.isPurchasing,
                    purchaseAction: viewModel.purchase,
                    checkOwnedProductsAction: viewModel.checkOwnedProducts,
                    showFAQ: $showFAQ
                )
            }
        }
        .background(Color("AppBackgroundColor"))
        .alert("Subscription & Lifetime Unlock FAQ", isPresented: $showFAQ) {
            Button("Close", role: .cancel) { }
        } message: {
            Text("""
                • Subscription gives you access while active; billed monthly or annually.

                • Lifetime Unlock is a one-time purchase with permanent access.

                • You can manage or cancel your subscription anytime in your Apple ID settings.
                """)
        }
    }
}

#Preview {
    PurchaseOptionsSection(viewModel: PurchaseViewVM())
}
