//
//  DrinkMenuRowView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/26/25.
//

import SwiftUI

struct DrinkMenuRowView: View {
    let item: CachedDrinkItem
    @Binding var draggingItem: CachedDrinkItem?
    let drinkMenuVM: DrinkMenuVM

    var body: some View {
        let isBeingDragged = draggingItem?.id == item.id

        let dropDelegate = DrinkDropDelegate(
            item: item,
            drinkMenuVM: drinkMenuVM,
            currentItem: $draggingItem
        )

        DrinkMenuModel(
            drink: DrinkItem(item),
            isBeingDragged: isBeingDragged,
            onDragStart: {
                // Stronger feedback on drag start
                Haptics.impact(style: .heavy)
                if draggingItem?.id != item.id {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        draggingItem = item
                    }
                }
            },
            onDragEnd: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        draggingItem = nil
                    }
                }
            }
        )
        .onDrag {
            withAnimation(.easeInOut(duration: 0.15)) {
                draggingItem = item
            }
            return NSItemProvider(object: item.id as NSString)
        } preview: {
            Image(systemName: "circle.fill")
                .resizable()
                .frame(width: 1, height: 1)
                .opacity(0.001)
        }
        .onDrop(of: [.text], delegate: dropDelegate)
    }
}
