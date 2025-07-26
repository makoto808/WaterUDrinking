//
//  ManageDrinksView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/26/25.
//

import SwiftData
import SwiftUI

struct ManageDrinksView: View {
    @Environment(DrinkListVM.self) private var drinkListVM
    @Environment(\.modelContext) private var modelContext

    @State private var showAddDrinkSheet = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(drinkListVM.items.enumerated()), id: \.1.id) { index, drink in
                    HStack {
                        Image(drink.img)
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text(drink.name)
                    }
                }
                .onMove { indices, newOffset in
                    drinkListVM.items.move(fromOffsets: indices, toOffset: newOffset)
                    saveNewOrder()
                }
            }
            .navigationTitle("Manage Drinks")
            .toolbar {
                EditButton()
                Button {
                    showAddDrinkSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddDrinkSheet) {
                AddDrinkView()
            }
        }
    }

    func saveNewOrder() {
        for (index, drink) in drinkListVM.items.enumerated() {
            let drinkName = drink.name

            let fetch = FetchDescriptor<UserArrangedDrinkItem>(
                predicate: #Predicate<UserArrangedDrinkItem> { item in
                    item.name == drinkName
                }
            )

            if let match = try? modelContext.fetch(fetch).first {
                match.arrayOrderValue = index
            }
        }

        do {
            try modelContext.save()
        } catch {
            print("Failed to save order: \(error)")
        }
    }


}


#Preview {
    ManageDrinksView()
}
