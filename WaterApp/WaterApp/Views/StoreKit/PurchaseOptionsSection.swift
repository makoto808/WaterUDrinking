//
//  PurchaseOptionsSection.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/15/25.
//

import SwiftUI
import StoreKit

struct PurchaseOptionsSection: View {
    @Bindable var viewModel: PurchaseViewVM

    var body: some View {
        if viewModel.isLoading {
            ProgressView("Loading Products...")
                .progressViewStyle(CircularProgressViewStyle())
                .padding()
        } else {
            VStack(spacing: 16) {
                if let monthly = viewModel.monthlyProduct {
                    PurchaseRow(title: "Pro Monthly Plan", description: "$1.99 / month") {
                        Task { await viewModel.purchase(monthly) }
                    }
                }

                if let annual = viewModel.annualProduct {
                    PurchaseRow(title: "Pro Annual Plan", description: "$14.99 / year") {
                        Task { await viewModel.purchase(annual) }
                    }
                }

                if let oneTime = viewModel.oneTimeProduct {
                    PurchaseRow(title: "Pro One-Time Unlock", description: oneTime.displayPrice) {
                        Task { await viewModel.purchase(oneTime) }
                    }
                }
            }
            .background(Color("AppBackgroundColor"))
        }
    }
}

#Preview {
    PurchaseOptionsSection(viewModel: PurchaseViewVM())
}
