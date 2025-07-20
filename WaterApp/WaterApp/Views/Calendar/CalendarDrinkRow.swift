//
//  CalendarDrinkRow.swift
//  WaterApp
//
//  Created by Gregg Abe on 6/29/25.
//

import SwiftUI

struct CalendarDrinkRow: View {
    @Environment(DrinkListVM.self) private var drinkListVM

    let purchaseManager: PurchaseManager
    let drink: CachedDrinkItem
    let onDelete: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(drink.img)
                .calendarDrinkRowImage()

            VStack(alignment: .leading, spacing: 4) {
                Text(drink.name)
                    .fontBarLabel()

                Text("\(drink.volume, specifier: "%.1f") oz")
                    .fontBarLabel2()
            }

            Spacer()

            PremiumButtonToggle(
                action: {
                    onDelete()
                },
                label: {
                    ZStack(alignment: .topTrailing) {
                        Image(systemName: "trash")
                            .buttonTrash()

                        if !purchaseManager.hasProAccess {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.red)
                                .font(.caption2)
                                .background(Color.white.clipShape(Circle()))
                                .offset(x: 6, y: -6)
                        }
                    }
                },
                purchaseManager: purchaseManager
            )
        }
    }
}
