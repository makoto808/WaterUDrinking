//
//  PremiumButtonToggle.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/19/25.
//

import SwiftUI

struct PremiumButtonToggle<Label: View>: View {
    @Environment(DrinkListVM.self) private var drinkListVM
    @Environment(\.dismiss) private var dismiss  // Add dismiss environment

    let action: () -> Void
    let label: () -> Label
    let purchaseManager: PurchaseManager

    var body: some View {
        Button {
            if purchaseManager.hasProAccess {
                action()
            } else {
                dismiss()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    drinkListVM.navPath.append(.purchaseView)
                }
            }
        } label: {
            label()
        }
    }
}
