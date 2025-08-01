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
    
    var currentMonth: Date = Date()
    var selectedDate: Date? = nil
    var cachedItems: [CachedDrinkItem] = []
    var userGoalModel: UserGoal?
    var showAlert = false
    var drinkToDelete: CachedDrinkItem? = nil
    
    private let calendar: Calendar = {
        var cal = Calendar.current
        cal.firstWeekday = 1
        return cal
    }()
    
    // MARK: - Setup
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
    
    // MARK: - Computed Properties
    func totalOunces(for date: Date) -> Double {
        cachedItems
            .filter { calendar.isDate($0.date, inSameDayAs: date) }
            .reduce(0) { $0 + $1.volume }
    }
    
    func percentageOfGoal(for date: Date, goal: Double) -> Int {
        let oz = totalOunces(for: date)
        guard goal > 0 else { return 0 }
        return Int(min((oz / goal) * 100, 999))
    }
    
    // MARK: - Fetching
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
    
    // MARK: - Calendar
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

    func toggleSelectedDate(_ date: Date) {
        if let selected = selectedDate, calendar.isDate(selected, inSameDayAs: date) {
            selectedDate = nil
        } else {
            selectedDate = date
        }
    }
    
    func changeMonth(by value: Int) {
        if let newMonth = calendar.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newMonth
            fetchDrinkItemsForMonth()
        }
    }
    
    // MARK: - Actions
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
    var drinkDates: Set<Date> {
        Set(cachedItems.map { calendar.startOfDay(for: $0.date) })
    }
    
    var drinksForSelectedDate: [CachedDrinkItem] {
        guard let selected = selectedDate else { return [] }
        return cachedItems
            .filter { calendar.isDate($0.date, inSameDayAs: selected) }
            .sorted { $0.date > $1.date } // <- this line
    }
    
    var totalOunces: Double {
        drinksForSelectedDate.reduce(0) { $0 + $1.volume }
    }
    
    //NOTE: Might delete later, must ask user for a starting goal
    var userGoal: Double {
        userGoalModel?.goal ?? 64
    }
}

