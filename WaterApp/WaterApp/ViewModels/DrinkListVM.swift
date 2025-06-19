//
//  DrinkListVM.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/2/25.
//

import SwiftUI
import Observation
import SwiftData

@Observable final class DrinkListVM {
    private var modelContext: ModelContext?
    var navPath: [NavPath] = []

    var selectedItemIndex: Int?
    
    var settingsDetent = PresentationDetent.medium
    var showingCustomOzView = false
    var showingCustomDrinkView = false
    var showAlert = false
    var value = 0.0

    // MARK: - Drink Items
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
            totalOz = items.reduce(0.0) { $0 + $1.volume }
            percentTotal = totalOzGoal == 0 ? 0 : totalOz / totalOzGoal * 100
        }
    }

    var totalOz: Double = 0.0
    var percentTotal: Double = 0.0
    var totalOzGoal: Double = 120

    init() {
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
    
    func parseNewCachedItem(for item: DrinkItem) -> CachedDrinkItem? {
        guard let i = selectedItemIndex else { return nil }
        if value == 0 {
            showAlert = true
        } else {
            items[i].volume += value
        }
        guard let index = items.firstIndex(where: { $0.name == item.name }) else {
            return nil
        }
        let newItem = CachedDrinkItem(
            date: Date(),
            name: item.name,
            img: item.img,
            volume: value,
            arrayOrderValue: index
        )
        return newItem
    }

    // MARK: - Caching
    @objc private func cacheDrinkItems() {
        guard let modelContext else { return }
        do {
            try modelContext.transaction {
                // DELETE today's items only
                let today = Calendar.current.startOfDay(for: Date())
                let predicate = #Predicate<CachedDrinkItem> { $0.date >= today }
                let todayItems = try modelContext.fetch(FetchDescriptor(predicate: predicate))

                for item in todayItems {
                    modelContext.delete(item)
                }

                // SAVE each item fresh
                for (index, item) in items.enumerated() {
                    var cached = CachedDrinkItem(item)
                    cached.arrayOrderValue = index
                    cached.date = Date() // ✅ Explicitly set the date to now
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
            let today = Calendar.current.startOfDay(for: Date())
            let predicate = #Predicate<CachedDrinkItem> { $0.date >= today }
            let fetchDescriptor = FetchDescriptor<CachedDrinkItem>(predicate: predicate)

            let cached = try modelContext.fetch(fetchDescriptor)

            if cached.isEmpty {
                print("No cached items found, using default drinks")
            } else {
                let cachedDrinks = cached.map { DrinkItem($0) }
                for i in 0..<items.count {
                    let item = items[i]
                    for cachedDrink in cachedDrinks {
                        if cachedDrink.name == item.name {
                            items[i].volume += cachedDrink.volume
                            break
                        }
                    }
                }
            }
        } catch {
            print("Failed to load cached drink items: \(error)")
        }
    }
}

