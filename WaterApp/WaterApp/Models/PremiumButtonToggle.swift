//
//  PremiumButtonToggle.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/19/25.
//

import SwiftUI

struct PremiumButtonToggle<Label: View>: View {
    let action: () -> Void
    let label: () -> Label
    let purchaseManager: PurchaseManager

    @Environment(DrinkListVM.self) private var drinkListVM

    var body: some View {
        Button {
            if purchaseManager.hasProAccess {
                action()
            } else {
                drinkListVM.navPath.append(.purchaseView)
            }
        } label: {
            label()
        }
    }
}
