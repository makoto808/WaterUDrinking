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
    var navPath: [NavPath] = []

    var selectedItemIndex: Int?

    // MARK: - Default Items
    private let defaultItems: [DrinkItem] = [
        DrinkItem(name: "Water", img: "waterBottle", volume: 0.0),
        DrinkItem(name: "Tea", img: "tea", volume: 0.0),
        DrinkItem(name: "Coffee", img: "coffee", volume: 0.0),
        DrinkItem(name: "Soda", img: "soda", volume: 0.0),
        DrinkItem(name: "Juice", img: "juice", volume: 0.0),
        DrinkItem(name: "Milk", img: "milk", volume: 0.0),
        DrinkItem(name: "Energy Drink", img: "energyDrink", volume: 0.0),
        DrinkItem(name: "Beer", img: "beer", volume: 0.0)
    ]

    // MARK: - Drink Items
    var items: [DrinkItem] = [] {
        didSet {
            totalOz = items.reduce(0.0) { $0 + $1.volume }
            percentTotal = totalOzGoal == 0 ? 0 : totalOz / totalOzGoal * 100
        }
    }

    var totalOz: Double = 0.0
    var percentTotal: Double = 0.0
    var totalOzGoal: Double = 120

//     MARK: - Fixed Order for Sorting
    private let fixedDrinkOrder = [
        "Water", "Tea", "Coffee", "Soda", "Juice", "Milk", "Energy Drink", "Beer"
    ]

    init() {
        self.items = defaultItems
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(cacheDrinkItems),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
    }

    func setSelectedItemIndex(for drink: DrinkItem) {
        selectedItemIndex = items.firstIndex { $0.name == drink.name }
    }

    func setModelContext(_ modelContext: ModelContext) {
        self.modelContext = modelContext
        self.modelContext!.autosaveEnabled = true
    }

    // MARK: - Caching
    @objc private func cacheDrinkItems() {
        guard let modelContext else { return }
        do {
            try modelContext.transaction {
                let oldItems = try modelContext.fetch(FetchDescriptor<CachedDrinkItem>())
                for item in oldItems {
                    modelContext.delete(item)
                }

                for (index, item) in items.enumerated() {
                    var cached = CachedDrinkItem(item)
                    cached.arrayOrderValue = index
                    modelContext.insert(cached)
                }

                try modelContext.save()
            }
        } catch {
            print("Error caching drink items: \(error)")
        }
    }

    // MARK: - Load from Cache
    func loadFromCache() {
        guard let modelContext else {
            print("ModelContext is nil")
            return
        }

        do {
            let cached = try modelContext.fetch(FetchDescriptor<CachedDrinkItem>())
            if cached.isEmpty {
                print("No cached items found, using default drinks")
                items = defaultItems
            } else {
                items = cached.map { DrinkItem($0) }
                sortItemsByFixedOrder()
            }
        } catch {
            print("Failed to load cached drink items: \(error)")
        }
    }

    // MARK: - Helper to Enforce Order
    private func sortItemsByFixedOrder() {
        items.sort {
            guard
                let firstIndex = fixedDrinkOrder.firstIndex(of: $0.name),
                let secondIndex = fixedDrinkOrder.firstIndex(of: $1.name)
            else { return false }
            return firstIndex < secondIndex
        }
    }
}
