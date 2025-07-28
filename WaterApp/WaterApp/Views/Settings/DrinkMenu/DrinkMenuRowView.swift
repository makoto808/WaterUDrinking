////
////  DrinkMenuRowView.swift
////  WaterApp
////
////  Created by Gregg Abe on 7/26/25.
////
//
//import SwiftUI
//
//struct DrinkMenuRowView: View {
//    let item: CachedDrinkItem
//    @Binding var draggingItem: CachedDrinkItem?
//    @Environment(DrinkMenuVM.self) private var drinkMenuVM
//
//    @GestureState private var dragOffset: CGSize = .zero
//
//    var body: some View {
//        let isDragging = draggingItem?.id == item.id
//
//        DrinkMenuModel(drink: DrinkItem(item), isBeingDragged: isDragging)
//            .offset(y: isDragging ? dragOffset.height : 0)
//            .animation(nil, value: dragOffset)  // Disable implicit animation on offset
//            .zIndex(isDragging ? 1 : 0)
//            .gesture(
//                DragGesture(minimumDistance: 10)
//                    .updating($dragOffset) { value, state, _ in
//                        state = value.translation
//                    }
//                    .onChanged { value in
//                        guard let dragging = draggingItem,
//                              let fromIndex = drinkMenuVM.menuItems.firstIndex(of: dragging),
//                              let toIndex = drinkMenuVM.menuItems.firstIndex(of: item),
//                              fromIndex != toIndex else { return }
//
//                        withAnimation {
//                            drinkMenuVM.menuItems.move(
//                                fromOffsets: IndexSet(integer: fromIndex),
//                                toOffset: toIndex > fromIndex ? toIndex + 1 : toIndex
//                            )
//                            drinkMenuVM.moveDrink(
//                                fromOffsets: IndexSet(integer: fromIndex),
//                                toOffset: toIndex > fromIndex ? toIndex + 1 : toIndex
//                            )
//                        }
//                        draggingItem = item
//                    }
//                    .onEnded { _ in
//                        draggingItem = nil
//                    }
//            )
//            .onLongPressGesture(minimumDuration: 0.1) {
//                draggingItem = item
//            }
//    }
//}
