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

    // New parameter to control whether .button1() style is applied
    var useButton1Style: Bool = true

    // Init for title-only usage
    init(
        action: @escaping () -> Void,
        title: String,
        useButton1Style: Bool = true
    ) where Label == EmptyView {
        self.action = action
        self.title = title
        self.label = nil
        self.useButton1Style = useButton1Style
    }

    // Init for custom label usage
    init(
        action: @escaping () -> Void,
        useButton1Style: Bool = true,
        @ViewBuilder label: () -> Label
    ) {
        self.action = action
        self.label = label()
        self.title = nil
        self.useButton1Style = useButton1Style
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
        .applyIf(useButton1Style) {
            $0.button1()
        }
    }
}

// Helper View extension for conditionally applying modifiers
extension View {
    @ViewBuilder
    func applyIf<T: View>(_ condition: Bool, transform: (Self) -> T) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
