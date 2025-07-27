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

            ScrollView {
                LazyVStack(spacing: 6) {
                    ForEach(drinkMenuVM.availableDrinks) { drink in
                        DrinkMenuModel(drink: drink)
                    }
                }
                .padding(.top, 12)
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

#Preview {
    let modelContainer = try! ModelContainer(for: CachedDrinkItem.self)
    let modelContext = modelContainer.mainContext

    let mockDrinkMenuVM = DrinkMenuVM(context: modelContext)
    let mockDrinkListVM = DrinkListVM()

    DrinkMenuView()
        .modelContainer(modelContainer)
        .environment(mockDrinkListVM)
        .environment(mockDrinkMenuVM)
}
