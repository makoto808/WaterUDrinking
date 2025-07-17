//
//  PurchaseView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/9/25.
//

import StoreKit
import SwiftUI
import ConfettiSwiftUI

struct PurchaseView: View {
    @Environment(DrinkListVM.self) private var drinkListVM
    @State private var purchaseViewVM = PurchaseViewVM()
    @State private var confettiCounter = 0
    
    var body: some View {
        ZStack {
            Color("AppBackgroundColor").ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 32) {
                    Text("Upgrade To Pro")
                        .fontMediumTitle()
                    
                    PurchaseOptionsSection(viewModel: purchaseViewVM)
                    
                    // Removed PurchasedView here
                    
                    Button("Restore Purchase") {
                        Task {
                            await purchaseViewVM.restorePurchases()
                            await purchaseViewVM.refreshSubscriptions()
                        }
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
                .task {
                    await purchaseViewVM.loadProducts()
                    await purchaseViewVM.refreshSubscriptions()
                }
                .sheet(isPresented: $purchaseViewVM.showingSignIn) {
                    Text("Custom sign-in view (optional)")
                }
            }
        }
    }
}

#Preview {
    PurchaseView()
        .environment(DrinkListVM())
}
