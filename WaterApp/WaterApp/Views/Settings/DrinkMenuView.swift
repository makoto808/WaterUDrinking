//
//  DrinkMenuView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/24/25.
//

import SwiftData
import SwiftUI

struct DrinkMenuView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(DrinkListVM.self) private var drinkListVM
    @Environment(DrinkMenuVM.self) private var drinkMenuVM

    var body: some View {
        ZStack {
            Color("AppBackgroundColor").ignoresSafeArea()

            VStack {
                List {
                    ForEach(drinkMenuVM.availableDrinks) { drink in
                        DrinkMenuModel(drink: drink)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                }
                .listStyle(.plain)
            }
        }
        .background(Color("AppBackgroundColor"))
        .backChevronButton(using: drinkListVM)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Drink Menu")
                    .fontBarLabel()
            }
        }
    }
}
