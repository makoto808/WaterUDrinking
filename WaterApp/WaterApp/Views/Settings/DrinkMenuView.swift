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

    @State private var draggingItem: CachedDrinkItem?

    var body: some View {
        ZStack {
            Color("AppBackgroundColor").ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    ForEach(drinkMenuVM.menuItems) { item in
                        DrinkMenuRowView(
                            item: item,
                            draggingItem: $draggingItem,
                            drinkMenuVM: drinkMenuVM
                        )
                    }
                }
                .transaction { $0.disablesAnimations = true }
                .padding(.top, 10)
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
