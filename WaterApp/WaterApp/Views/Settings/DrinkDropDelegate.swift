//
//  DrinkDropDelegate.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/26/25.
//

import SwiftUI

struct DrinkDropDelegate: DropDelegate {
    let item: CachedDrinkItem
    let drinkMenuVM: DrinkMenuVM
    @Binding var currentItem: CachedDrinkItem?

    func performDrop(info: DropInfo) -> Bool {
        withAnimation(.easeInOut(duration: 0.15)) {
            currentItem = nil
        }
        return true
    }


    func dropEntered(info: DropInfo) {
        guard let currentItem = currentItem,
              currentItem.id != item.id,
              let fromIndex = drinkMenuVM.menuItems.firstIndex(of: currentItem),
              let toIndex = drinkMenuVM.menuItems.firstIndex(of: item) else {
            return
        }

        withAnimation {
            drinkMenuVM.menuItems.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: toIndex > fromIndex ? toIndex + 1 : toIndex)
        }
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        DropProposal(operation: .move)
    }

    func dropExited(info: DropInfo) {}
}
