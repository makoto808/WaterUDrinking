//
//  DrinkListVM.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/2/25.
//

import Observation
import SwiftData
import SwiftUI

@Observable final class DrinkListVM {
    var navPath: [NavPath] = []
    var selectedItemIndex: Int?
    var selectedCalendarDate: Date? = nil
    var settingsDetent = PresentationDetent.medium
    var showCustomOzView = false
    var showCustomDrinkView = false
    var showPastDrinkSheet = false
    var showAlert = false
    var value = 0.0
    var totalOz: Double = 0.0
    var percentTotal: Double = 0.0
    var totalOzGoal: Double = 120 {
        didSet {
            percentTotal = totalOzGoal == 0 ? 0 : totalOz / totalOzGoal * 100
        }
    }

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

    func setSelectedItemIndex(for drink: DrinkItem) {
        selectedItemIndex = items.firstIndex { $0.name == drink.name }
    }

    func parseNewCachedItem(for item: DrinkItem, volume customVolume: Double? = nil) -> CachedDrinkItem? {
        guard selectedItemIndex != nil else { return nil }
        let volumeToUse = customVolume ?? value
        guard volumeToUse > 0 else { return nil }

        guard let index = items.firstIndex(where: { $0.name == item.name }) else {
            return nil
        }

        let usedDate = selectedCalendarDate ?? Date()
        print("💧 Saving drink for date: \(usedDate)")

        let newItem = CachedDrinkItem(
            date: usedDate,
            name: item.name,
            img: item.img,
            volume: volumeToUse,
            arrayOrderValue: index
        )

        return newItem
    }


    // MARK: - Load from Cache
    func loadFromCache(_ modelContext: ModelContext) {
        do {
            let cached = try fetchTodaysCachedDrinks(modelContext)
            guard !cached.isEmpty else {
                print("No cached items found, using default drinks")
                return
            }
            let cachedDrinks = cached.map { DrinkItem($0) }
            for i in 0..<items.count {
                for cachedDrink in cachedDrinks {
                    if cachedDrink.name == items[i].name {
                        items[i].volume += cachedDrink.volume
                    }
                }
            }
        } catch {
            print("Error fetching [CachedDrinkItem]")
        }
    }

    func deleteTodaysItems(_ modelContext: ModelContext) {
        do {
            let cached = try fetchTodaysCachedDrinks(modelContext)
            for item in cached {
                modelContext.delete(item)
            }
            try modelContext.save()
        } catch {
            print("Error deleting cached drinks: \(error)")
        }
    }
    
    // MARK: - User Goal
    func fetchUserGoal(_ context: ModelContext) -> UserGoal? {
        var descriptor = FetchDescriptor<UserGoal>(
            predicate: #Predicate { $0.id == "uniqueUserGoal" }
        )
        descriptor.fetchLimit = 1

        return (try? context.fetch(descriptor).first) ?? nil
    }

    func setGoalAndDismiss(_ goal: Double, context: ModelContext) {
        self.totalOzGoal = goal
        self.navPath = []

        do {
            if let existing = fetchUserGoal(context) {
                existing.goal = goal
            } else {
                let newGoal = UserGoal(goal: goal)
                context.insert(newGoal)
            }
            try context.save()
        } catch {
            print("Failed to save goal: \(error)")
        }
    }

    func loadUserGoal(context: ModelContext) {
        if let savedGoal = fetchUserGoal(context) {
            self.totalOzGoal = savedGoal.goal
        }
    }

    // MARK: - Cache
    private func fetchTodaysCachedDrinks(_ modelContext: ModelContext) throws -> [CachedDrinkItem] {
        let today = Calendar.current.startOfDay(for: Date())
        let predicate = #Predicate<CachedDrinkItem> { $0.date >= today }
        let fetchDescriptor = FetchDescriptor<CachedDrinkItem>(predicate: predicate)
        let cached = try modelContext.fetch(fetchDescriptor)
        return cached
    }
    
    func refreshFromCache(_ modelContext: ModelContext) {
        do {
            let cached = try fetchTodaysCachedDrinks(modelContext)
            let cachedDrinks = cached.map { DrinkItem($0) }
            let updatedItems = items.map { originalItem -> DrinkItem in
                let volumeFromCache = cachedDrinks
                    .filter { $0.name == originalItem.name }
                    .reduce(0.0) { $0 + $1.volume }
                return DrinkItem(
                    name: originalItem.name,
                    img: originalItem.img,
                    volume: volumeFromCache
                )
            }
            self.items = updatedItems
        } catch {
            print("Failed to refresh drinks: \(error)")
            let resetItems = items.map { item in
                DrinkItem(name: item.name, img: item.img, volume: 0.0)
            }
            self.items = resetItems
        }
    }
    
    func refreshFromCache(for date: Date, modelContext: ModelContext) {
        do {
            let cached = try fetchCachedDrinks(for: date, modelContext)
            let cachedDrinks = cached.map { DrinkItem($0) }
            let updatedItems = items.map { originalItem -> DrinkItem in
                let volumeFromCache = cachedDrinks
                    .filter { $0.name == originalItem.name }
                    .reduce(0.0) { $0 + $1.volume }
                return DrinkItem(
                    name: originalItem.name,
                    img: originalItem.img,
                    volume: volumeFromCache
                )
            }
            self.items = updatedItems
        } catch {
            print("Failed to refresh drinks for date: \(error)")
            let resetItems = items.map { item in
                DrinkItem(name: item.name, img: item.img, volume: 0.0)
            }
            self.items = resetItems
        }
    }

    private func fetchCachedDrinks(for date: Date, _ modelContext: ModelContext) throws -> [CachedDrinkItem] {
        let startOfDay = Calendar.current.startOfDay(for: date)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        let predicate = #Predicate<CachedDrinkItem> { $0.date >= startOfDay && $0.date < endOfDay }
        let fetchDescriptor = FetchDescriptor<CachedDrinkItem>(predicate: predicate)
        return try modelContext.fetch(fetchDescriptor)
    }

}
