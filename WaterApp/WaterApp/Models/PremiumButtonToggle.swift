//
//  PremiumButtonToggle.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/19/25.
//

import SwiftUI

struct PremiumButtonToggle<Label: View>: View {
    @Environment(DrinkListVM.self) private var drinkListVM
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject var purchaseManager: PurchaseManager

    let action: () -> Void
    let label: Label?
    let title: String?

    // Init for title-only usage
    init(
        action: @escaping () -> Void,
        title: String
    ) where Label == EmptyView {
        self.action = action
        self.title = title
        self.label = nil
    }

    // Init for custom label usage
    init(
        action: @escaping () -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.action = action
        self.label = label()
        self.title = nil
    }

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
            if let label = label {
                label
            } else if let title = title {
                if purchaseManager.hasProAccess {
                    Text(title)
                } else {
                    SwiftUI.Label(title, systemImage: "lock.fill")
                }
            } else {
                EmptyView()
            }
        }
        .button1()
    }
}
