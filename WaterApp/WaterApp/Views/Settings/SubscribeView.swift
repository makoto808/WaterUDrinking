//
//  SubscribeView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/3/25.
//

import StoreKit
import SwiftUI

struct SubscribeView: View {
    @State private var showingSignIn = false

    var body: some View {
        SubscriptionStoreView(productIDs:  ["com.hackingwithswift.plus.subscription"])
            .storeButton(.visible, for: .restorePurchases, .redeemCode, .policies, .signIn)
            .subscriptionStorePolicyDestination(for: .privacyPolicy) {
                Text("Privacy policy here")
            }
            .subscriptionStorePolicyDestination(for: .termsOfService) {
                Text("Terms of service here")
            }
            .subscriptionStoreSignInAction {
                showingSignIn = true
            }
            .sheet(isPresented: $showingSignIn) {
                Text("Sign in here")
            }
            .subscriptionStoreControlStyle(.prominentPicker)
    }
}
#Preview {
    SubscribeView()
}
