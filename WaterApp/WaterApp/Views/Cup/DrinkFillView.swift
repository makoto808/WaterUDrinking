//
//  DrinkFillView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/29/25.
//

import SwiftData
import SwiftUI

struct DrinkFillView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(DrinkListVM.self) private var drinkListVM
    
    @State private var lastHapticValue: Double = 0.0
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
    
    let item: DrinkItem
    let purchaseManager: PurchaseManager
    
    var body: some View {
        @Bindable var drinkListVM = drinkListVM
        
        VStack {
            Spacer()
            Spacer()
            
            Text("\(drinkListVM.value.formatted()) oz")
                .fontTitle()
            
            // TODO: Adds an overly layer for fill effect with Slider()
            Image(item.img)
                .drinkFillResize()
                .sheet(isPresented: $drinkListVM.showCustomDrinkView) {
                    CustomDrinkView()
                }
            
            Slider(value: $drinkListVM.value, in: 0...20, step: 0.1)
                .padding(30)
                .onChange(of: drinkListVM.value) { oldValue, newValue in
                    let roundedValue = (newValue * 10).rounded() / 10.0
                    if abs(roundedValue - lastHapticValue) >= 0.1 {
                        feedbackGenerator.impactOccurred()
                        lastHapticValue = roundedValue
                    }
                }
            
            CustomDrinkButtonRow(drinkListVM: drinkListVM, item: item, purchaseManager: purchaseManager)

            Spacer()
        }
        .background(Color("AppBackgroundColor"))
        .backChevronButton(using: drinkListVM)
        .onAppear {
            drinkListVM.setSelectedItemIndex(for: item)
            feedbackGenerator.prepare()
        }
        .onDisappear {
            drinkListVM.selectedItemIndex = nil
        }
    }
}

//#Preview {
//    let mockItem = DrinkItem(name: "Water", img: "waterBottle", volume: 8.0)
//    
//    let mockVM = DrinkListVM()
//    mockVM.items = [mockItem]
//    
//    return DrinkFillView(item: mockItem)
//        .environment(mockVM)
//}
