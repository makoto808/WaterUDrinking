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
    var customOzDetent = PresentationDetent.fraction(2/6)
    var modelContext: ModelContext!
    var navPath: [NavPath] = []
    var percentTotal: Double = 0.0
    var selectedCalendarDate: Date? = nil
    var selectedItemIndex: Int?
    var settingsDetent = PresentationDetent.medium
    var showAlert = false
    var showCustomDrinkView = false
    var showCustomOzView = false
    var showPastDrinkSheet = false
    var todayItems: [DrinkItem] = []
    var totalOz: Double = 0.0
    var value = 0.0
    
    var totalOzGoal: Double = 120 {
        didSet {
            percentTotal = totalOzGoal == 0 ? 0 : totalOz / totalOzGoal * 100
        }
    }

    // MARK: - Drink Items
    
    var items: [DrinkItem] = [] {
        didSet {
            totalOz = items.reduce(0.0) { $0 + $1.hydrationAdjustedVolume }
            percentTotal = totalOzGoal == 0 ? 0 : totalOz / totalOzGoal * 100
        }
    }

    init(context: ModelContext) {
        self.modelContext = context
        self.loadUserGoal(context: context)
        self.loadUserDrinkItems(context)
        self.syncDefaultDrinks()
        self.refreshTodayItems(modelContext: context)
    }

    // MARK: - Drink Selection
    
    func setSelectedItemIndex(for drink: DrinkItem) {
        selectedItemIndex = items.firstIndex { $0.name == drink.name }
    }

    // MARK: - Creating Cached Drink Item
    
    func parseNewCachedItem(for item: DrinkItem, volume customVolume: Double? = nil) -> CachedDrinkItem? {
        guard selectedItemIndex != nil else { return nil }
        let volumeToUse = customVolume ?? value
        guard volumeToUse > 0 else { return nil }

        guard let index = items.firstIndex(where: { $0.name == item.name }) else {
            return nil
        }

        let currentTime = Date()
        let usedDate = selectedCalendarDate.map { combine(date: $0, time: currentTime) } ?? currentTime

        if let selectedDate = selectedCalendarDate {
            print("💧 Saving drink:")
            print("    📅 Selected day: \(selectedDate.formatted(date: .abbreviated, time: .omitted))")
            print("    ⏰ Current time: \(currentTime.formatted(date: .omitted, time: .standard))")
            print("    📌 Combined date: \(usedDate.formatted(date: .abbreviated, time: .standard))")
        } else {
            print("💧 Saving drink for today: \(usedDate.formatted(date: .abbreviated, time: .standard))")
        }

        print("Adding \(item.name) with volume \(volumeToUse)")
        print("Hydration rate: \(item.hydrationRate), Adjusted volume: \(volumeToUse * Double(item.hydrationRate) / 100.0)")
        
        let newItem = CachedDrinkItem(
            date: usedDate,
            name: item.name,
            img: item.img,
            volume: volumeToUse,
            hydrationRate: item.hydrationRate,  // make sure hydrationRate is passed here
            category: item.category,
            arrayOrderValue: index
        )

        return newItem
    }

    // Combines selected date and time for a drink entry
    func combine(date: Date, time: Date) -> Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time)

        var combined = DateComponents()
        combined.year = dateComponents.year
        combined.month = dateComponents.month
        combined.day = dateComponents.day
        combined.hour = timeComponents.hour
        combined.minute = timeComponents.minute
        combined.second = timeComponents.second

        return calendar.date(from: combined) ?? date
    }

    // MARK: - Caching (Fetch, Delete, Refresh)
    
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
                    volume: volumeFromCache,
                    hydrationRate: originalItem.hydrationRate,
                    category: originalItem.category
                )
            }
            self.items = updatedItems
        } catch {
            print("Failed to refresh drinks: \(error)")
            let resetItems = items.map { item in
                DrinkItem(
                    name: item.name,
                    img: item.img,
                    volume: 0.0,
                    hydrationRate: item.hydrationRate,
                    category: item.category
                )
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
                    volume: volumeFromCache,
                    hydrationRate: originalItem.hydrationRate,
                    category: originalItem.category
                )
            }
            self.items = updatedItems
        } catch {
            print("Failed to refresh drinks for date: \(error)")
            let resetItems = items.map { item in
                DrinkItem(
                    name: item.name,
                    img: item.img,
                    volume: 0.0,
                    hydrationRate: item.hydrationRate,
                    category: item.category
                )
            }
            self.items = resetItems
        }
    }

    func refreshTodayItems(modelContext: ModelContext) {
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
                    volume: volumeFromCache,
                    hydrationRate: originalItem.hydrationRate,
                    category: originalItem.category
                )
            }
            todayItems = updatedItems
            // update totals based on todayItems:
            totalOz = todayItems.reduce(0.0) { $0 + $1.hydrationAdjustedVolume }
            percentTotal = totalOzGoal == 0 ? 0 : totalOz / totalOzGoal * 100
        } catch {
            print("Failed to refresh today's drinks: \(error)")
            todayItems = items.map { item in
                DrinkItem(
                    name: item.name,
                    img: item.img,
                    volume: 0.0,
                    hydrationRate: item.hydrationRate,
                    category: item.category
                )
            }
            totalOz = 0
            percentTotal = 0
        }
    }
    
    private func fetchTodaysCachedDrinks(_ modelContext: ModelContext) throws -> [CachedDrinkItem] {
        let today = Calendar.current.startOfDay(for: Date())
        let predicate = #Predicate<CachedDrinkItem> { $0.date >= today }
        let fetchDescriptor = FetchDescriptor<CachedDrinkItem>(predicate: predicate)
        let cached = try modelContext.fetch(fetchDescriptor)
        return cached
    }
    

    private func fetchCachedDrinks(for date: Date, _ modelContext: ModelContext) throws -> [CachedDrinkItem] {
        let startOfDay = Calendar.current.startOfDay(for: date)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        let predicate = #Predicate<CachedDrinkItem> { $0.date >= startOfDay && $0.date < endOfDay }
        let fetchDescriptor = FetchDescriptor<CachedDrinkItem>(predicate: predicate)
        return try modelContext.fetch(fetchDescriptor)
    }
    
    var totalOuncesToday: Double {
        let today = Calendar.current.startOfDay(for: Date())
        let endOfToday = Calendar.current.date(byAdding: .day, value: 1, to: today)!

        let predicate = #Predicate<CachedDrinkItem> { $0.date >= today && $0.date < endOfToday }
        let fetchDescriptor = FetchDescriptor<CachedDrinkItem>(predicate: predicate)

        do {
            let cached = try modelContext.fetch(fetchDescriptor)
            return cached.reduce(0.0) { $0 + $1.volume }
        } catch {
            print("Error fetching today's drinks: \(error)")
            return 0.0
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

    // MARK: - Load User Drinks
    
    func loadUserDrinkItems(_ context: ModelContext) {
        do {
            let descriptor = FetchDescriptor<UserArrangedDrinkItem>(
                sortBy: [SortDescriptor(\.arrayOrderValue)]
            )
            let userDrinks = try context.fetch(descriptor)

            if userDrinks.isEmpty {
                // First-time setup fallback:
                // Just save default drinks to persistence (once)
                saveDefaultDrinksToUserDrinks(context)
                // And set items to defaultDrinks, but ONLY ONCE here:
                items = DefaultDrinks.all
            } else {
                // Load from persisted data only, no duplication
                items = userDrinks.map { userDrink in
                    DrinkItem(
                        name: userDrink.name,
                        img: userDrink.img,
                        volume: 0.0,
                        hydrationRate: hydrationRateForDrink(named: userDrink.name),
                        category: categoryForDrink(named: userDrink.name)
                    )
                }
            }
        } catch {
            print("Failed to load UserDrinkItems: \(error)")
        }
    }

    private func saveDefaultDrinksToUserDrinks(_ context: ModelContext) {
        let defaultItems = DefaultDrinks.all
        for (index, drink) in defaultItems.enumerated() {
            let newUserDrink = UserArrangedDrinkItem(name: drink.name, img: drink.img, arrayOrderValue: index)
            context.insert(newUserDrink)
        }
        do {
            try context.save()
        } catch {
            print("Failed to save default UserDrinkItems: \(error)")
        }
    }

    // MARK: - Drink Defaults / Hydration Lookup
    
    func hydrationRateForDrink(named name: String) -> Int {
        DefaultDrinks.all.first(where: { $0.name == name })?.hydrationRate ?? 100
    }

    func categoryForDrink(named name: String) -> DrinkCategory {
        DefaultDrinks.all.first(where: { $0.name == name })?.category ?? .water
    }
    
    func syncDefaultDrinks() {
        let currentNames = Set(items.map { $0.name })
        let newDrinks = DefaultDrinks.all.filter { !currentNames.contains($0.name) }
        if !newDrinks.isEmpty {
            items.append(contentsOf: newDrinks)
        }
    }
}
