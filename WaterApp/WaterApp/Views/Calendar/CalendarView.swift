//
//  CalendarView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/26/25.
//

import SwiftData
import SwiftUI

struct CalendarView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(DrinkListVM.self) private var drinkListVM
    @Environment(CalendarHomeVM.self) private var calendarVM
    
    @EnvironmentObject var purchaseManager: PurchaseManager

    @Binding var isShowingDrinkDetails: Bool
    
    private let calendar: Calendar = {
        var cal = Calendar.current
        cal.firstWeekday = 1
        return cal
    }()
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    private let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
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
                            .fontSmallTitle2()
                            .frame(maxWidth: .infinity)
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
            
            if let selected = calendarVM.selectedDate {
                CalendarDrinkList(
                    drinks: calendarVM.drinksForSelectedDate,
                    selectedDate: selected
                )
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
                let isSelected = calendar.isDate(date, inSameDayAs: calendarVM.selectedDate ?? Date())
                let hasEvent = calendarVM.drinkDates.contains(calendar.startOfDay(for: date))
                let goalMet = calendarVM.percentageOfGoal(for: date, goal: calendarVM.userGoal) >= 100

                CalendarDayCell(
                    date: date,
                    isInMonth: isInMonth,
                    isSelected: isSelected,
                    hasEvent: hasEvent,
                    goalMet: goalMet
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
}

//#Preview {
//    struct PreviewWrapper: View {
//        @State private var showingDetails = false
//        let purchaseManager = PurchaseManager.shared
//
//        var body: some View {
//            CalendarView(purchaseManager: purchaseManager, isShowingDrinkDetails: $showingDetails)
//                .environment(CalendarHomeVM())
//        }
//    }
//    return PreviewWrapper()
//}
