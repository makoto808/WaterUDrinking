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

    private let calendar: Calendar = {
        var cal = Calendar.current
        cal.firstWeekday = 1
        return cal
    }()

    // MARK: - Setup

    func setModelContext(_ modelContext: ModelContext) {
        self.modelContext = modelContext
        self.modelContext?.autosaveEnabled = true
    }

    // MARK: - Fetching

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

    // MARK: - Navigation

    func changeMonth(by value: Int) {
        if let newMonth = calendar.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newMonth
            fetchDrinkItemsForMonth()
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
            .sorted { $0.arrayOrderValue < $1.arrayOrderValue }
    }

    var totalOunces: Double {
        drinksForSelectedDate.reduce(0) { $0 + $1.volume }
    }
    
    // MARK: - Calendar
    var monthDates: [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: currentMonth),
              let firstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
              let lastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end.addingTimeInterval(-1))
        else { return [] }

        var dates: [Date] = []
        var current = firstWeek.start
        while current < lastWeek.end {
            dates.append(current)
            current = calendar.date(byAdding: .day, value: 1, to: current)!
        }
        return dates
    }

    
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
    
    
    func toggleSelectedDate(_ date: Date) {
        if let selected = selectedDate, calendar.isDate(selected, inSameDayAs: date) {
            selectedDate = nil
        } else {
            selectedDate = date
        }
    }

    
    
    
}

