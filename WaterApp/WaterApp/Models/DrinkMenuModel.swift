//
//  DrinkMenuModel.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/26/25.
//

import SwiftUI

struct DrinkMenuModel: View {
    let drink: DrinkItem

    var body: some View {
        Button(action: {
            
        }) {
            HStack {
                Image(drink.img)
                    .resizable()
                    .frame(width: 37, height: 37)
                    .padding(.leading, 15)
                    .padding(.trailing, 10)

                Text(drink.name)
                    .fontSmallTitle()

                Spacer()
            }
            .contentShape(Rectangle())
            .frame(height: 70)
            .background(Color.black.opacity(0.07))
            .cornerRadius(13)
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    DrinkMenuModel(drink: DrinkItem(name: "Water", img: "waterBottle", volume: 8))
}
