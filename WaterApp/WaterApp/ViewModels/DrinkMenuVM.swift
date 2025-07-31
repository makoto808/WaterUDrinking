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
        syncAndReloadDrinks()
    }
    
    func loadArrangedDrinks() {
        let descriptor = FetchDescriptor<UserArrangedDrinkItem>(sortBy: [.init(\.arrayOrderValue)])
        
        if let results = try? modelContext.fetch(descriptor), !results.isEmpty {
            arrangedDrinks = results
        } else {
            // Insert default drinks if none exist
            arrangedDrinks = []
            for (index, drink) in DefaultDrinks.all.enumerated() {
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
    
    func syncAndReloadDrinks() {
        loadArrangedDrinks()
        syncDefaultDrinks()
        loadArrangedDrinks()
    }
}
