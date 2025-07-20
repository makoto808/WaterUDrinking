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
                    Text("🎊 Upgrade to Pro 🎊")
                        .fontMediumTitle()
                    
                    // Show PurchasedView if user owns lifetime or subscription
                    if purchaseViewVM.ownsLifetimeUnlock || purchaseViewVM.currentSubscription != nil {
                        PurchasedView(
                            ownsLifetimeUnlock: purchaseViewVM.ownsLifetimeUnlock,
                            currentSubscription: purchaseViewVM.currentSubscription,
                            confettiCounter: $confettiCounter
                        )
                        
                        // Show lifetime unlock purchase option here
                        if let oneTime = purchaseViewVM.oneTimeProduct, !purchaseViewVM.ownsLifetimeUnlock {
                            VStack(spacing: 10) {
                                PurchaseRow(
                                    title: "Upgrade to Lifetime Access",
                                    description: oneTime.displayPrice
                                ) {
                                    Task {
                                        await purchaseViewVM.purchase(oneTime)
                                    }
                                }
                                Text("One-time unlock: Pay once, use forever — no recurring fees.")
                                    .fontProDescription2()
                            }
                            .padding(.horizontal)
                        }
                    } else {
                        // Otherwise show regular purchase options for monthly/annual/one-time
                        PurchaseOptionsSection(
                            viewModel: purchaseViewVM,
                            confettiCounter: $confettiCounter
                        )
                    }
                        
                    Button("Restore Purchase") {
                        Task {
                            await purchaseViewVM.restorePurchases()
                            await purchaseViewVM.refreshSubscriptions()
                        }
                    }
                    .font(.custom("ArialRoundedMTBold", size: 18))
                    .alert("No purchases found", isPresented: $purchaseViewVM.showNoPurchasesFoundAlert) {
                        Button("OK") { }
                    }
                    .alert("Restore Failed", isPresented: $purchaseViewVM.showRestoreErrorAlert) {
                        Button("OK") { }
                    } message: {
                        Text("We couldn’t restore your purchases. Please try again later.")
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
        .confettiCannon(
            trigger: $confettiCounter,
            num: purchaseViewVM.ownsLifetimeUnlock ? 50 : 220,
            rainHeight: purchaseViewVM.ownsLifetimeUnlock ? 400 : 500,
            openingAngle: .degrees(45),
            closingAngle: .degrees(135),
            radius: 600
        )
    }
}

#Preview {
    PurchaseView()
        .environment(DrinkListVM())
}
