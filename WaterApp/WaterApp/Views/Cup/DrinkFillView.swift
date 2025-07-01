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
    
    let item: DrinkItem
    
    var body: some View {
        @Bindable var drinkListVM = drinkListVM
        
        VStack {
            Spacer()
            Spacer()
            
            Text("\(drinkListVM.value.formatted()) oz")
                .fontTitle()
            
            // TODO: Adds an overly layer for fill effect with Slider()
            Image(item.img)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 500, alignment: .center)
                .sheet(isPresented: $drinkListVM.showCustomDrinkView) {
                    CustomDrinkView()
                }
            
            Slider(value: $drinkListVM.value, in: 0...20, step: 0.1)
                .padding(30)
            
            CustomDrinkButtonRow(drinkListVM: drinkListVM, item: item)
            
            Spacer()
        }
        .background(Color.backgroundWhite)
        .onAppear {
            drinkListVM.setSelectedItemIndex(for: item)
        }
        .onDisappear {
            drinkListVM.selectedItemIndex = nil
        }
    }
}

#Preview {
    let mockItem = DrinkItem(name: "Water", img: "waterBottle", volume: 8.0)
    
    let mockVM = DrinkListVM()
    mockVM.items = [mockItem]
    
    return DrinkFillView(item: mockItem)
        .environment(mockVM)
}
