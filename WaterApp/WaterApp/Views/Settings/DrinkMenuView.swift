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
    
    @State private var draggingItemIndex: Int? = nil
    @State private var dragOffset: CGFloat = 0
    @State private var accumulatedOffset: CGFloat = 0
    @State private var lastSwapIndex: Int? = nil
 
    var body: some View {
        VStack {
            Text("The Top 8 Drinks from Your List Are Displayed on the Home Screen")
                .fontDrinkMenuDescription()
            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(Array(drinkMenuVM.availableDrinks.enumerated()), id: \.element.name) { index, drink in
                        DrinkMenuModel(drink: drink)
                            .scaleEffect(draggingItemIndex == index ? 1.05 : 1)          // Slightly bigger when dragging
                            .shadow(color: draggingItemIndex == index ? Color.black.opacity(0.2) : .clear, radius: 5, x: 0, y: 2) // Add subtle shadow
                            .offset(y: draggingItemIndex == index ? (accumulatedOffset + dragOffset) : 0)
                            .zIndex(draggingItemIndex == index ? 1 : 0)
                            .animation(.interactiveSpring(), value: drinkMenuVM.availableDrinks)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        if draggingItemIndex == nil {
                                            draggingItemIndex = index
                                            lastSwapIndex = index
                                        }
                                        dragOffset = value.translation.height
                                        
                                        guard let draggingIndex = draggingItemIndex else { return }
                                        
                                        let rowHeight: CGFloat = 65 // Adjust to your row height
                                        let threshold = rowHeight / 2
                                        
                                        let totalOffset = accumulatedOffset + dragOffset
                                        
                                        if totalOffset > threshold, draggingIndex < drinkMenuVM.availableDrinks.count - 1 {
                                            withAnimation {
                                                drinkMenuVM.moveAvailableDrink(from: draggingIndex, to: draggingIndex + 1)
                                                draggingItemIndex = draggingIndex + 1
                                            }
                                            accumulatedOffset -= rowHeight
                                            dragOffset = 0
                                        } else if totalOffset < -threshold, draggingIndex > 0 {
                                            withAnimation {
                                                drinkMenuVM.moveAvailableDrink(from: draggingIndex, to: draggingIndex - 1)
                                                draggingItemIndex = draggingIndex - 1
                                            }
                                            accumulatedOffset += rowHeight
                                            dragOffset = 0
                                        }
                                    }
                                    .onEnded { _ in
                                        draggingItemIndex = nil
                                        dragOffset = 0
                                        accumulatedOffset = 0
                                        lastSwapIndex = nil
                                    }
                            )
                    }

                }
                .padding(.top, 10)
            }
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
