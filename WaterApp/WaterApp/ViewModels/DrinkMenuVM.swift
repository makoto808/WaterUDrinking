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
            for (index, drink) in Self.defaultDrinkItems.enumerated() {
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
    
    //NOTE: Used to clear drinkselection for debug purposes
    func resetArrangedDrinks() {
        let descriptor = FetchDescriptor<UserArrangedDrinkItem>()
        if let existing = try? modelContext.fetch(descriptor) {
            for drink in existing {
                modelContext.delete(drink)
            }
            try? modelContext.save()
            arrangedDrinks = []
            loadArrangedDrinks()
        }
    }

    static let defaultDrinkItems: [DrinkItem] = [
        DrinkItem(name: "Water", img: "waterBottle", volume: 0.0, hydrationRate: 100, category: .water),
        DrinkItem(name: "Tea", img: "tea", volume: 0.0, hydrationRate: 90, category: .tea),
        DrinkItem(name: "Coffee", img: "coffee", volume: 0.0, hydrationRate: 60, category: .coffee),
        DrinkItem(name: "Soda", img: "soda", volume: 0.0, hydrationRate: 70, category: .soda),
        DrinkItem(name: "Juice", img: "juice", volume: 0.0, hydrationRate: 80, category: .juice),
        DrinkItem(name: "Milk", img: "milk", volume: 0.0, hydrationRate: 85, category: .milk),
        DrinkItem(name: "Energy Drink", img: "energyDrink", volume: 0.0, hydrationRate: 60, category: .energy),
        DrinkItem(name: "Beer", img: "beer", volume: 0.0, hydrationRate: 50, category: .alcohol)
    ]
}
