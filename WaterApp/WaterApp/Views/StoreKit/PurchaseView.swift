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
                // Print debug logs when key properties change:
                .onChange(of: purchaseViewVM.isPurchased) { newValue in
                    print("DEBUG: isPurchased changed to \(newValue)")
                }
                .onChange(of: purchaseViewVM.ownsLifetimeUnlock) { newValue in
                    print("DEBUG: ownsLifetimeUnlock changed to \(newValue)")
                }
                .onChange(of: purchaseViewVM.currentSubscription?.id) { newValue in
                    print("DEBUG: currentSubscription changed to \(newValue ?? "nil")")
                }
            }
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

#Preview {
    PurchaseView()
        .environment(DrinkListVM())
}
