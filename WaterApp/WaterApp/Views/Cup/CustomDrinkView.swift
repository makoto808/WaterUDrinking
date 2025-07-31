//
//  CustomDrinkView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/31/25.
//

import SwiftUI

struct CustomDrinkView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(DrinkListVM.self) private var drinkListVM
    
    let currentItem: DrinkItem
    let allItems: [DrinkItem]

    var relatedDrinks: [DrinkItem] {
        allItems.filter {
            $0.category == currentItem.category && $0.id != currentItem.id
        }
    }

    var body: some View {
        List {
            ForEach(relatedDrinks) { drink in
                Section {
                    Button {
                        drinkListVM.navPath.append(.drinkFillView(drink))

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            dismiss()
                        }
                    } label: {
                        HStack {
                            Image(drink.img)
                                .CDVresize()
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(drink.name).fontSmallTitle()
                                    .padding(.bottom, 5)
                                
                                Text("\(drink.hydrationRate)% Rate of Hydration").fontSmallTitle2()
                            }
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    let sampleItem = DrinkItem(
        name: "Water",
        img: "waterBottle",
        volume: 8.0,
        hydrationRate: 100,
        category: .water
    )
    
    let mockItems: [DrinkItem] = [
        sampleItem,
        DrinkItem(name: "Sparkling Water", img: "waterBottle", volume: 8.0, hydrationRate: 100, category: .water),
        DrinkItem(name: "Coconut Water", img: "coconutWater", volume: 8.0, hydrationRate: 90, category: .water),
        DrinkItem(name: "Mineral Water", img: "mineralWater", volume: 8.0, hydrationRate: 100, category: .water),
        DrinkItem(name: "Espresso", img: "espresso", volume: 2.0, hydrationRate: 60, category: .coffee)
    ]
    
    return CustomDrinkView(currentItem: sampleItem, allItems: mockItems)
}
