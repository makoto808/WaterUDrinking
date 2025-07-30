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
    @EnvironmentObject var purchaseManager: PurchaseManager
    @State private var lastHapticValue: Double = 0.0
    
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
    let item: DrinkItem
    
    var body: some View {
        @Bindable var drinkListVM = drinkListVM
        
        VStack {
            Spacer()
            Spacer()
            
            Text("\(drinkListVM.value.formatted()) oz")
                .fontTitle()
                .padding(.bottom, 20)
            
            Image(item.img)
                .drinkFillResize()
                .sheet(isPresented: $drinkListVM.showCustomDrinkView) {
                    CustomDrinkView(currentItem: item, allItems: drinkListVM.items)
                        .presentationDetents([.large])
                }
            
            CapsuleSlider(value: $drinkListVM.value, range: 0...20, step: 0.1) { newValue in
                let roundedValue = (newValue * 10).rounded() / 10.0
                if abs(roundedValue - lastHapticValue) >= 0.1 {
                    feedbackGenerator.impactOccurred()
                    lastHapticValue = roundedValue
                }
            }
            .padding(.top, 50)
            .padding(.horizontal, 25)
            
            CustomDrinkButtonRow(drinkListVM: drinkListVM, item: item)
                .padding(.horizontal, 15)

            Spacer()
        }
        .background(Color("AppBackgroundColor"))
        .backChevronButtonHome(using: drinkListVM)
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
