//
//  DrinkMenuView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/24/25.
//

import SwiftUI
import SwiftData

struct DrinkMenuView: View {
    @Environment(DrinkListVM.self) private var drinkListVM
    @Environment(DrinkMenuVM.self) private var drinkMenuVM
    
    var body: some View {
        VStack {
            Text("The Top 8 Drinks from Your List Are Displayed on the Home Screen")
                .fontDrinkMenuDescription()
                .padding()
            
            List {
                ForEach(drinkMenuVM.availableDrinks, id: \.name) { drink in
                    DrinkMenuModel(drink: drink)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)  // removes white capsule background
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .onMove { indices, newOffset in
                    drinkMenuVM.availableDrinks.move(fromOffsets: indices, toOffset: newOffset)
                }
            }
            .listStyle(.plain) // remove insetGrouped styling which adds background & padding
            .scrollContentBackground(.hidden) // removes default list background
            .background(Color.clear) // just in case
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
    }
}
