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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation {
                currentItem = nil
            }
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

        if fromIndex != toIndex {
            withAnimation {
                drinkMenuVM.menuItems.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: toIndex > fromIndex ? toIndex + 1 : toIndex)
            }
            // Medium impact on each move
            Haptics.impact(style: .light)
        }
    }

    func dropUpdated(info: DropInfo) -> DropProposal? {
        DropProposal(operation: .move)
    }

    func dropExited(info: DropInfo) {}
}
