//
//  DrinkMenuModel.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/26/25.
//

import SwiftUI
import SwiftData

struct DrinkMenuModel: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let drink: DrinkItem  // Accept DrinkItem now
    
    var body: some View {
        HStack {
            Image(drink.img)
                .resizable()
                .frame(width: 45, height: 45)
                .padding(.leading, 15)
                .padding(.trailing, 10)
            
            Text(drink.name)
                .fontSmallTitle()
            
            Spacer()
        }
        .contentShape(Rectangle())
        .frame(height: 65)
        .background(
            colorScheme == .dark
            ? Color.white.opacity(0.08)
            : Color.black.opacity(0.07)
        )
        .cornerRadius(13)
        .padding(.vertical, 1)
        .padding(.horizontal, 20)
    }
}


//#Preview {
//    DrinkMenuModel(
//        drink: DrinkItem(name: "Water", img: "waterBottle", volume: 8.0)
//    )
//    .padding()
//    .background(Color(.systemBackground))
//    .environment(\.colorScheme, .dark)
//}
//
