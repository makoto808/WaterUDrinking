//
//  CalendarHomeVM.swift
//  WaterApp
//
//  Created by Ryan Kanno on 4/19/25.
//

import Foundation
import Observation
import SwiftData
import SwiftUI

@Observable final class CalendarHomeVM {
    private var modelContext: ModelContext?
    
    var cachedItems: [CachedDrinkItem] = []
    var currentMonth: Date = Date()
    var drinkToDelete: CachedDrinkItem? = nil
    var selectedDate: Date? = nil
    var showAlert = false
    var userGoalModel: UserGoal?
    
    // MARK: - Calendar Configuration
    
    private let calendar: Calendar = {
        var cal = Calendar.current
        cal.firstWeekday = 1
        return cal
    }()
    
    // MARK: - Computed Cache Mapping
    
    // Groups drink items by the start of each day
    var drinksByDate: [Date: [CachedDrinkItem]] {
        Dictionary(grouping: cachedItems) { item in
            calendar.startOfDay(for: item.date)
        }
    }

    // MARK: - ModelContext Setup
    
    func setModelContext(_ modelContext: ModelContext) {
        self.modelContext = modelContext
        self.modelContext?.autosaveEnabled = true
        
        let descriptor = FetchDescriptor<UserGoal>()
        do {
            let goals = try modelContext.fetch(descriptor)
            self.userGoalModel = goals.first
        } catch {
            print("Failed to fetch UserGoal: \(error)")
        }
    }
    
    // MARK: - Computed Totals
    
    // Calculates total adjusted ounces for a specific date
    func totalOunces(for date: Date) -> Double {
        let filtered = cachedItems.filter { calendar.isDate($0.date, inSameDayAs: date) }
        for item in filtered {
            print("Item: \(item.name), volume: \(item.volume), hydrationRate: \(item.hydrationRate), adjusted: \(hydrationAdjustedVolume(for: item))")
        }
        return filtered.reduce(0) { $0 + hydrationAdjustedVolume(for: $1) }
    }

    // Returns hydration goal percentage for a specific date
    func percentageOfGoal(for date: Date, goal: Double) -> Int {
        let oz = totalOunces(for: date)
        guard goal > 0 else { return 0 }
        return Int(min((oz / goal) * 100, 999))
    }
    
    // MARK: - Fetching Methods
    
    // Fetches drink items only for the given day
    func fetchDrinks(for date: Date) -> [CachedDrinkItem] {
        guard let context = modelContext else { return [] }
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let descriptor = FetchDescriptor<CachedDrinkItem>(
            predicate: #Predicate { $0.date >= startOfDay && $0.date < endOfDay },
            sortBy: [.init(\.date, order: .forward)]
        )
        
        do {
            return try context.fetch(descriptor)
        } catch {
            print("Fetch failed: \(error)")
            return []
        }
    }
    
    // Fetches all drink items for the currently selected month
    func fetchDrinkItemsForMonth() {
        guard let context = modelContext else { return }
        
        let start = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth))!
        let end = calendar.date(byAdding: .month, value: 1, to: start)!
        
        let descriptor = FetchDescriptor<CachedDrinkItem>(
            predicate: #Predicate { $0.date >= start && $0.date < end }
        )
        
        do {
            cachedItems = try context.fetch(descriptor)
        } catch {
            print("Failed to fetch drink items: \(error)")
        }
    }
    
    // MARK: - Calendar Display Helpers
    
    var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }
    
    var monthYearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
    
    // Generates 35–42 grid dates for currentMonth, including padding
    var monthDates: [Date] {
        let calendar = Calendar(identifier: .gregorian)
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth))!
        let firstWeekdayOfMonth = calendar.component(.weekday, from: startOfMonth)
        let paddingDays = (firstWeekdayOfMonth - calendar.firstWeekday + 7) % 7
        let totalDays = calendar.range(of: .day, in: .month, for: currentMonth)!.count
        let gridStartDate = calendar.date(byAdding: .day, value: -paddingDays, to: startOfMonth)!
        let numberOfDays = ((paddingDays + totalDays) <= 35) ? 35 : 42
        let dates = (0..<numberOfDays).compactMap { offset in
            calendar.date(byAdding: .day, value: offset, to: gridStartDate)
        }
        return dates
    }

    // Toggle a selected calendar date; deselects if same date tapped
    func toggleSelectedDate(_ date: Date) {
        if let selected = selectedDate, calendar.isDate(selected, inSameDayAs: date) {
            selectedDate = nil
        } else {
            selectedDate = date
        }
    }
    
    // Shifts calendar month forward or backward by value (e.g. ±1)
    func changeMonth(by value: Int) {
        if let newMonth = calendar.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newMonth
            fetchDrinkItemsForMonth()
        }
    }
    
    // MARK: - Actions
    
    // Deletes drink and refreshes cache in associated view model
    func deleteDrink(_ drink: CachedDrinkItem, drinkListVM: DrinkListVM) {
        guard let context = modelContext else { return }
        context.delete(drink)
        do {
            try context.save()
            cachedItems.removeAll { $0.id == drink.id }
            drinkListVM.refreshFromCache(for: Date(), modelContext: context)
        } catch {
            print("Failed to delete drink: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Helpers
    
    // All unique dates that contain drinks
    var drinkDates: Set<Date> {
        Set(cachedItems.map { calendar.startOfDay(for: $0.date) })
    }
    
    // Returns drinks for selected date, sorted newest first
    var drinksForSelectedDate: [CachedDrinkItem] {
        guard let selected = selectedDate else { return [] }
        return cachedItems
            .filter { calendar.isDate($0.date, inSameDayAs: selected) }
            .sorted { $0.date > $1.date } // <- this line
    }
    
    // Total adjusted ounces for selected day
    var totalOunces: Double {
        drinksForSelectedDate.reduce(0) { $0 + $1.hydrationAdjustedVolume }
    }
    
    // Returns user goal (default 64oz if not found)
    var userGoal: Double {
        userGoalModel?.goal ?? 64
    }
    
    // Adjusts volume for drink hydration rate (e.g. coffee counts as less)
    private func hydrationAdjustedVolume(for item: CachedDrinkItem) -> Double {
        return item.volume * (Double(item.hydrationRate) / 100.0)
    }
}
