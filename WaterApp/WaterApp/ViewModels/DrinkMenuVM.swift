//
//  DrinkMenuVM.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/26/25.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
class DrinkMenuVM {
    var arrangedDrinks: [UserArrangedDrinkItem] = []
    let modelContext: ModelContext
    
    init(context: ModelContext) {
        self.modelContext = context
        loadArrangedDrinks()
    }
    
    func loadArrangedDrinks() {
        let descriptor = FetchDescriptor<UserArrangedDrinkItem>(sortBy: [.init(\.arrayOrderValue)])
        if let results = try? modelContext.fetch(descriptor), !results.isEmpty {
            arrangedDrinks = results
        } else {
            // Insert default drinks if none exist
            arrangedDrinks = []
            for (index, drink) in Self.defaultDrinks.enumerated() {
                let newItem = UserArrangedDrinkItem(name: drink.name, img: drink.img, arrayOrderValue: index)
                modelContext.insert(newItem)
                arrangedDrinks.append(newItem)
            }
            try? modelContext.save()
        }
    }
    
    func moveDrink(fromOffsets: IndexSet, toOffset: Int) {
        arrangedDrinks.move(fromOffsets: fromOffsets, toOffset: toOffset)
        
        for (index, drink) in arrangedDrinks.enumerated() {
            drink.arrayOrderValue = index
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Failed to save drink order: \(error)")
        }
    }
    
    static let defaultDrinks: [DrinkItem] = [
        DrinkItem(name: "Water", img: "waterBottle", volume: 0),
        DrinkItem(name: "Tea", img: "tea", volume: 0),
        DrinkItem(name: "Coffee", img: "coffee", volume: 0),
        DrinkItem(name: "Soda", img: "soda", volume: 0),
        DrinkItem(name: "Juice", img: "juice", volume: 0),
        DrinkItem(name: "Milk", img: "milk", volume: 0),
        DrinkItem(name: "Energy Drink", img: "energyDrink", volume: 0),
        DrinkItem(name: "Beer", img: "beer", volume: 0)
    ]
}
