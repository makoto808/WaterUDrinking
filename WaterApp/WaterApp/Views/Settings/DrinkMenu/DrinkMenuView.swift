//
//  DrinkMenuView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/24/25.
//

import SwiftUI
import SwiftData

struct DrinkMenuView: View {
    @EnvironmentObject var purchaseManager: PurchaseManager
    @Environment(DrinkMenuVM.self) private var drinkMenuVM
    @Environment(DrinkListVM.self) private var drinkListVM
    
    var body: some View {
        VStack {
            Text("The Top 8 Drinks from Your List Are Displayed on the Home Screen")
                .fontDrinkMenuDescription()
                .padding()
            
            List {
                ForEach(drinkMenuVM.arrangedDrinks, id: \.id) { drink in
                    DrinkMenuModel(
                        drink: DrinkItem(
                            name: drink.name,
                            img: drink.img,
                            volume: 0.0,
                            hydrationRate: drinkListVM.hydrationRateForDrink(named: drink.name),
                            category: drinkListVM.categoryForDrink(named: drink.name)
                        )
                    )
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }
                .onMove { indices, newOffset in
                    if purchaseManager.hasProAccess {
                        drinkMenuVM.moveDrink(fromOffsets: indices, toOffset: newOffset)
                    } else {
                        let generator = UIImpactFeedbackGenerator(style: .heavy)
                        generator.impactOccurred()

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            drinkListVM.navPath.append(.purchaseView)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            .environment(\.editMode, .constant(.active))
        }
        .background(Color("AppBackgroundColor").ignoresSafeArea())
        .backChevronButton(using: drinkListVM)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Drink Menu")
                    .fontBarLabel()
            }
        }
        .onAppear {
            drinkMenuVM.syncAndReloadDrinks()
        }
    }
}
