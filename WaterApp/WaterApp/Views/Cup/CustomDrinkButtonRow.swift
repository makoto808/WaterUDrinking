//
//  CustomDrinkButtonRow.swift
//  WaterApp
//
//  Created by Gregg Abe on 6/30/25.
//

import SwiftUI

struct CustomDrinkButtonRow: View {
    @Environment(\.modelContext) private var modelContext
    
    @EnvironmentObject var purchaseManager: PurchaseManager
    
    @Bindable var drinkListVM: DrinkListVM

    let item: DrinkItem
    
    var body: some View {
        HStack {
            Button {
                drinkListVM.showCustomDrinkView.toggle()
            } label: {
                Image(item.img)
                    .customDrinkButton()
            }

            Spacer()

            Button("+ \(item.name) ") {
                if drinkListVM.value == 0 {
                    drinkListVM.showAlert = true
                    return
                }

                drinkListVM.setSelectedItemIndex(for: item)
                
                print("Adding \(item.name) with volume \(drinkListVM.value)")
                
                if let newItem = drinkListVM.parseNewCachedItem(for: item) {
                    modelContext.insert(newItem)
                    do {
                        try modelContext.save()
                        drinkListVM.refreshFromCache(modelContext)
                    } catch {
                        print("Failed to save: \(error.localizedDescription)")
                    }
                } else {
                    print("Failed to parse new cached item for \(item.name)")
                }

                drinkListVM.value = 0
                drinkListVM.navPath.removeAll()
            }
            .drinkFilllViewButtonStyle()
            .alert("You Didn't Drink Anything!", isPresented: $drinkListVM.showAlert) {
                Button("Dismiss") {}
            }

            Spacer()

            Button {
                drinkListVM.showCustomOzView.toggle()
            } label: {
                Image(systemName: "ellipsis.circle")
                    .customDrinkButton()
            }
            .sheet(isPresented: $drinkListVM.showCustomOzView) {
                CustomOzView(item: item)
                    .presentationDetents([.fraction(2/6)], selection: $drinkListVM.customOzDetent)
            }
        }
        .padding(20)
    }
}
