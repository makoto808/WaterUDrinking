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
    var availableDrinks: [DrinkItem] = [
        DrinkItem(name: "Water", img: "waterBottle", volume: 0.0),
        DrinkItem(name: "Tea", img: "tea", volume: 0.0),
        DrinkItem(name: "Coffee", img: "coffee", volume: 0.0),
        DrinkItem(name: "Soda", img: "soda", volume: 0.0),
        DrinkItem(name: "Juice", img: "juice", volume: 0.0),
        DrinkItem(name: "Milk", img: "milk", volume: 0.0),
        DrinkItem(name: "Energy Drink", img: "energyDrink", volume: 0.0),
        DrinkItem(name: "Beer", img: "beer", volume: 0.0)
    ]
    
    private let context: ModelContext
    var menuItems: [CachedDrinkItem] = []
    
    init(context: ModelContext) {
        self.context = context
        loadDrinks()
    }
    
    func loadDrinks() {
        let descriptor = FetchDescriptor<CachedDrinkItem>(sortBy: [.init(\.arrayOrderValue)])
        
        if let result = try? context.fetch(descriptor), !result.isEmpty {
            // Found saved drinks, just use them
            menuItems = result
        } else {
            // No saved drinks — insert default list
            menuItems = []
            for (index, drink) in Self.defaultDrinks.enumerated() {
                let newItem = CachedDrinkItem(drink)
                newItem.arrayOrderValue = index
                context.insert(newItem)
                menuItems.append(newItem)
            }
            try? context.save()
        }
    }
    
    func addDrink(_ item: DrinkItem) {
        guard menuItems.count < 8 else { return }
        let newItem = CachedDrinkItem(item)
        newItem.arrayOrderValue = menuItems.count
        context.insert(newItem)
        menuItems.append(newItem)
        try? context.save()
    }
    
    func removeDrink(_ item: CachedDrinkItem) {
        context.delete(item)
        menuItems.removeAll { $0.id == item.id }
        try? context.save()
    }
    
    func moveDrink(fromOffsets: IndexSet, toOffset: Int) {
        menuItems.move(fromOffsets: fromOffsets, toOffset: toOffset)
        for (index, item) in menuItems.enumerated() {
            item.arrayOrderValue = index
        }
        try? context.save()
    }
    
    func isValid() -> Bool {
        menuItems.count == 8
    }
}

extension DrinkMenuVM {
    static let defaultDrinks: [DrinkItem] = [
        DrinkItem(name: "Water", img: "waterBottle", volume: 0.0),
        DrinkItem(name: "Tea", img: "tea", volume: 0.0),
        DrinkItem(name: "Coffee", img: "coffee", volume: 0.0),
        DrinkItem(name: "Soda", img: "soda", volume: 0.0),
        DrinkItem(name: "Juice", img: "juice", volume: 0.0),
        DrinkItem(name: "Milk", img: "milk", volume: 0.0),
        DrinkItem(name: "Energy Drink", img: "energyDrink", volume: 0.0),
        DrinkItem(name: "Beer", img: "beer", volume: 0.0)
    ]
}
