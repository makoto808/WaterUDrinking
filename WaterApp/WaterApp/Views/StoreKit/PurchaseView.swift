//
//  PurchaseView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/9/25.
//

import StoreKit
import SwiftUI

struct PurchaseView: View {
    @Environment(DrinkListVM.self) private var drinkListVM
    @State private var purchaseViewVM = PurchaseViewVM()
    
    var body: some View {
        ZStack {
            Color("AppBackgroundColor").ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 32) {
                    Text("Upgrade To Pro")
                        .fontMediumTitle()
                    
                    PurchaseOptionsSection(viewModel: purchaseViewVM)
                    
                    if purchaseViewVM.isPurchased {
                        Text("✅ Purchase successful!")
                            .foregroundColor(.green)
                    }
                    
                    // ✅ Remove this if already shown in PurchaseOptionsSection
                    /*
                    if let sub = purchaseViewVM.currentSubscription {
                        Text("You are subscribed: \(sub.displayName)")
                    }
                    */

                    Button("Restore Purchase") {
                        purchaseViewVM.restorePurchases()
                    }
                    .alert("No purchases found", isPresented: $purchaseViewVM.showNoPurchasesFoundAlert) {
                        Button("OK", role: .cancel) { }
                    }
                    .padding(.top, -16)

                    PurchaseLegalSection()
                }
                .disabled(purchaseViewVM.isLoading)
                .opacity(purchaseViewVM.isLoading ? 0.5 : 1)
                .padding()
                .backChevronButton(using: drinkListVM)
            }
            .task {
                await purchaseViewVM.loadProducts()
                await purchaseViewVM.checkCurrentSubscription()
                await purchaseViewVM.checkOwnedProducts()
            }
            .sheet(isPresented: $purchaseViewVM.showingSignIn) {
                Text("Custom sign-in view (optional)")
            }
        }
    }
}

#Preview {
    PurchaseView()
        .environment(DrinkListVM())
}
