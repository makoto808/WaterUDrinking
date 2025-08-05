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
    let modelContext: ModelContext
    
    // The list of drinks displayed in the menu, ordered by user preference
    var arrangedDrinks: [UserArrangedDrinkItem] = []
    
    init(context: ModelContext) {
        self.modelContext = context
        syncAndReloadDrinks()
    }
    
    // MARK: - Load & Insert Default Drinks
    
    // Loads the user's arranged drinks from storage.
    func loadArrangedDrinks() {
        let descriptor = FetchDescriptor<UserArrangedDrinkItem>(sortBy: [.init(\.arrayOrderValue)])
        
        if let results = try? modelContext.fetch(descriptor), !results.isEmpty {
            arrangedDrinks = results
        } else {
            // If none exist, it inserts the default drink set.
            arrangedDrinks = []
            for (index, drink) in DefaultDrinks.all.enumerated() {
                let newItem = UserArrangedDrinkItem(name: drink.name, img: drink.img, arrayOrderValue: index)
                modelContext.insert(newItem)
                arrangedDrinks.append(newItem)
            }
            try? modelContext.save()
        }
    }

    // MARK: - Move/Reorder Logic
    
    // Reorders drinks in the list and updates their saved order
    func moveDrink(fromOffsets: IndexSet, toOffset: Int) {
        arrangedDrinks.move(fromOffsets: fromOffsets, toOffset: toOffset)
        
        // Update the array order for all items
        for (index, drink) in arrangedDrinks.enumerated() {
            drink.arrayOrderValue = index
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Failed to save drink order: \(error)")
        }
    }
    
    // MARK: - Debugging / Development Utilities
    
    // Clears all saved drink items and reloads the defaults
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

    // MARK: - Sync New Defaults
    
    // Adds new default drinks that don't exist in the user's list yet
    func syncDefaultDrinks() {
        let currentNames = Set(arrangedDrinks.map { $0.name })
        let newDrinks = DefaultDrinks.all.filter { !currentNames.contains($0.name) }
        
        if !newDrinks.isEmpty {
            for (index, drink) in newDrinks.enumerated() {
                let newItem = UserArrangedDrinkItem(
                    name: drink.name,
                    img: drink.img,
                    arrayOrderValue: arrangedDrinks.count + index
                )
                modelContext.insert(newItem)
                arrangedDrinks.append(newItem)
            }
            try? modelContext.save()
        }
    }
    // MARK: - Sync and Reload
    
    // Ensures user drinks are loaded and synced with defaults
    func syncAndReloadDrinks() {
        loadArrangedDrinks()
        syncDefaultDrinks()
        loadArrangedDrinks()
    }
}
