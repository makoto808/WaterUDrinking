//
//  DrinkListVM.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/2/25.
//

import UIKit
import Observation
import SwiftData

@Observable final class DrinkListVM {
    private var modelContext: ModelContext?
    var navPath: [NavPath] = [] //ryan lesson 146
    
    var selectedItemIndex: Int?
    
//    Used to display in DrinkSelectionView
    var items: [DrinkItem] = [
        DrinkItem(name: "Water", img: "waterBottle", volume: 0.0),
        DrinkItem(name: "Tea", img: "tea", volume: 0.0),
        DrinkItem(name: "Coffee", img: "coffee", volume: 0.0),
        DrinkItem(name: "Soda", img: "soda", volume: 0.0),
        DrinkItem(name: "Juice", img: "juice", volume: 0.0),
        DrinkItem(name: "Milk", img: "milk", volume: 0.0),
        DrinkItem(name: "Energy Drink", img: "energyDrink", volume: 0.0),
        DrinkItem(name: "Beer", img: "beer", volume: 0.0)
    ] {
        didSet {
            let sum = items.reduce(0.0) { $0 + $1.volume }
            totalOz = sum
            
            let sum2 = totalOz / totalOzGoal * 100
            percentTotal = sum2
        }
    }
    
    var totalOz: Double = 0.0
    var percentTotal: Double = 0.0
    var totalOzGoal: Double = 120 //Might change from GoalView
    
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cacheDrinkItems),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil)
    }
    
    func setSelectedItemIndex(for drink: DrinkItem) {
        var index: Int?
        for i in 0..<items.count {
            let currentItem = items[i]
            if currentItem.name == drink.name {
                index = i
                break
            }
        }
        selectedItemIndex = index
    }
    
    func setModelContext(_ modelContext: ModelContext) {
        self.modelContext = modelContext
        self.modelContext!.autosaveEnabled = true
    }
    
    @objc private func cacheDrinkItems() {
        guard let modelContext else { return }
        do {
            try modelContext.transaction {
                let oldItems = try modelContext.fetch(FetchDescriptor<CachedDrinkItem>())
                for item in oldItems {
                    modelContext.delete(item)
                }

                for item in items {
                    modelContext.insert(CachedDrinkItem(item))
                }

                try modelContext.save()
            }
        } catch {
            print("Error caching drink items: \(error)")
        }
    }

    
    func loadFromCache() {
        guard let modelContext else {
            print("ModelContext is nil")
            return
        }

        do {
            let cached = try modelContext.fetch(FetchDescriptor<CachedDrinkItem>())
            self.items = cached.map { DrinkItem($0) }
        } catch {
            print("Failed to load cached drink items: \(error)")
        }
    }

}


//@Observable does not need to confrom to ObservableObject




//@objc private func cacheDrinkItems() {
//    let cachedDrinks = items.map { item in
//        return CachedDrinkItem(item)
//    }
//    do {
//        try modelContext?.transaction {
//            for drink in cachedDrinks {
//                modelContext?.insert(drink)
//            }
//            try modelContext?.save()
//        }
//    } catch {
//        print(error)
//    }
//}
