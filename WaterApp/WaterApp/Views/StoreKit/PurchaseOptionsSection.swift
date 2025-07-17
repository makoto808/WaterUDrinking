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
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                LoadingView()
            } else if viewModel.isPurchased || viewModel.ownsLifetimeUnlock {
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
                    checkOwnedProductsAction: viewModel.checkOwnedProducts
                )
            }
        }
        .background(Color("AppBackgroundColor"))
    }
}

#Preview {
    PurchaseOptionsSection(viewModel: PurchaseViewVM())
}

#Preview {
    PurchaseOptionsSection(viewModel: PurchaseViewVM())
}
