//
//  CalendarDrinkRow.swift
//  WaterApp
//
//  Created by Gregg Abe on 6/29/25.
//

import SwiftUI

struct CalendarDrinkRow: View {
    let drink: CachedDrinkItem
    let onDelete: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(drink.img)
                .resizable()
                .frame(width: 60, height: 60)

            VStack(alignment: .leading, spacing: 4) {
                Text(drink.name)
                    .fontBarLabel()

                Text("\(drink.volume, specifier: "%.1f") oz")
                    .fontBarLabel2()
                    .foregroundColor(.gray)
            }

            Spacer()

            Button {
                onDelete()
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .buttonStyle(.plain)
        }
    }
}
