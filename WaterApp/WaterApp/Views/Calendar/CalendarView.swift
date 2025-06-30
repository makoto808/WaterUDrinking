//
//  CalendarView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/26/25.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(DrinkListVM.self) private var drinkListVM
    @Environment(CalendarHomeVM.self) private var calendarVM
    
    @Binding var isShowingDrinkDetails: Bool
    
    //    @State private var drinkItems: [CachedDrinkItem] = []
    //    @State private var currentMonth = Date()
    //    @State private var selectedDate: Date? = nil
    
    private let calendar: Calendar = {
        var cal = Calendar.current
        cal.firstWeekday = 1
        return cal
    }()
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    private let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    //    private var drinkDates: Set<Date> {
    //        Set(drinkItems.map { calendar.startOfDay(for: $0.date) })
    //    }
    
    //    private var drinksForSelectedDate: [CachedDrinkItem] {
    //        guard let selected = calendarVM.selectedDate
    // else { return [] }
    //        return drinkItems.filter { calendar.isDate($0.date, inSameDayAs: selected) }
    //    }
    
    var body: some View {
        let dates = calendarVM.monthDates
        
        VStack {
            Text(calendarVM.monthYearFormatter.string(from: calendarVM.currentMonth))
                .fontBarLabel()
                .padding()
            
            // Weekdays and Grid
            VStack {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(daysOfWeek, id: \.self) { day in
                        Text(day)
                            .fontCustomDrinkViewSubtitle()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.gray)
                    }
                }
                
                calendarGridView(for: dates)
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.width < -50 {
                                    calendarVM.changeMonth(by: 1)
                                } else if value.translation.width > 50 {
                                    calendarVM.changeMonth(by: -1)
                                }
                            }
                    )}
            
            if let selected = calendarVM.selectedDate
            {
                CalendarDrinkList(drinks: calendarVM.drinksForSelectedDate, selectedDate: selected)
                    .transition(.opacity)
            }
            
        }
        .animation(.easeInOut, value: calendarVM.currentMonth)
        .onAppear {
            calendarVM.setModelContext(modelContext)
            calendarVM.fetchDrinkItemsForMonth()
        }
        .onChange(of: calendarVM.cachedItems) {
            isShowingDrinkDetails = calendarVM.selectedDate != nil && !calendarVM.drinksForSelectedDate.isEmpty
        }
    }
    
    private func calendarGridView(for dates: [Date]) -> some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(dates, id: \.self) { date in
                let isInMonth = calendar.isDate(date, equalTo: calendarVM.currentMonth, toGranularity: .month)
                let isSelected = calendar.isDate(date, inSameDayAs: calendarVM.selectedDate
                                                 ?? Date())
                let hasEvent = calendarVM.drinkDates.contains(calendar.startOfDay(for: date))
                
                CalendarDayCell(
                    date: date,
                    isInMonth: isInMonth,
                    isSelected: isSelected,
                    hasEvent: hasEvent
                ) {
                    withAnimation(.easeInOut) {
                        calendarVM.toggleSelectedDate(date)
                        isShowingDrinkDetails = calendarVM.selectedDate != nil &&
                                                !calendarVM.drinksForSelectedDate.isEmpty
                    }
                }
            }
        }
    }
    
    //    private func updateDrinkQuery() {
    //        let start = calendar.date(from: calendar.dateComponents([.year, .month], from: calendarVM.currentMonth))!
    //        let end = calendar.date(byAdding: .month, value: 1, to: start)!
    //        let descriptor = FetchDescriptor<CachedDrinkItem>(
    //            predicate: #Predicate { $0.date >= start && $0.date < end }
    //        )
    //
    //        do {
    //            drinkItems = try modelContext.fetch(descriptor)
    //        } catch {
    //            print("Fetch failed: \(error)")
    //        }
    //    }
    
    //    private func changeMonth(by value: Int) {
    //        if let newMonth = calendar.date(byAdding: .month, value: value, to: calendarVM.currentMonth) {
    //            calendarVM.currentMonth = newMonth
    //        }
    //    }
    
    //    private func generateMonthDates(for month: Date) -> [Date] {
    //        guard let monthInterval = calendar.dateInterval(of: .month, for: month),
    //              let firstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
    //              let lastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end.addingTimeInterval(-1))
    //        else { return [] }
    //
    //        var dates: [Date] = []
    //        var current = firstWeek.start
    //
    //        while current < lastWeek.end {
    //            dates.append(current)
    //            current = calendar.date(byAdding: .day, value: 1, to: current)!
    //        }
    //
    //        return dates
    //    }
    
    //    private var monthYearFormatter: DateFormatter {
    //        let formatter = DateFormatter()
    //        formatter.dateFormat = "MMMM yyyy"
    //        return formatter
    //    }
    //
    //    private var dayFormatter: DateFormatter {
    //        let formatter = DateFormatter()
    //        formatter.dateFormat = "d"
    //        return formatter
    //    }
}

//TODO: Toggle systemImage if on premium account or not
//Button("Add Previous Drink", systemImage: "lock") {
//                //            }
//            .buttonCapsule()

#Preview {
    struct PreviewWrapper: View {
        @State private var showingDetails = false
        
        var body: some View {
            CalendarView(isShowingDrinkDetails: $showingDetails)
                .environment(CalendarHomeVM())
        }
    }
    
    return PreviewWrapper()
}
