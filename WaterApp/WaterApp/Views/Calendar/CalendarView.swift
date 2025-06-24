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
    @Environment(CalendarHomeVM.self) private var calendarHomeVM
    @Environment(DrinkListVM.self) private var drinkListVM

    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    private let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    private let calendar: Calendar = {
        var cal = Calendar.current
        cal.firstWeekday = 1
        return cal
    }()

    var body: some View {
        let dates = calendarHomeVM.monthDates
        VStack {
            Text(calendarHomeVM.monthYearFormatter.string(from: calendarHomeVM.currentMonth))
                .fontBarLabel()
                .padding()

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .fontCustomDrinkViewTitle()
                        .foregroundColor(.gray)
                }
            }

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(dates, id: \.self) { date in
                    let isInMonth = calendar.isDate(date, equalTo: calendarHomeVM.currentMonth, toGranularity: .month)
                    let isSelected = calendar.isDate(date, inSameDayAs: calendarHomeVM.selectedDate ?? Date())
                    let hasEvent = calendarHomeVM.drinkDates.contains(calendar.startOfDay(for: date))

                    Group {
                        if isInMonth {
                            Text(calendarHomeVM.dayFormatter.string(from: date))
                                .frame(width: 35, height: 35)
                                .background(
                                    isSelected ? Color.cyan :
                                    hasEvent ? Color.blue :
                                    Color.blue.opacity(0.2)
                                )
                                .cornerRadius(20)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        if let selected = calendarHomeVM.selectedDate,
                                           calendar.isDate(selected, inSameDayAs: date) {
                                            calendarHomeVM.selectedDate = nil
                                        } else {
                                            calendarHomeVM.selectedDate = date
                                        }
                                    }
                                }
                        } else {
                            Text("").frame(width: 35, height: 35)
                        }
                    }
                }
            }

            if calendarHomeVM.selectedDate != nil && !calendarHomeVM.drinksForSelectedDate.isEmpty {
                CupGoalSummaryView(oz: calendarHomeVM.totalOunces, goal: drinkListVM.totalOzGoal)
            }

            if calendarHomeVM.selectedDate != nil && !calendarHomeVM.drinksForSelectedDate.isEmpty {
                CalendarListView(drinks: calendarHomeVM.drinksForSelectedDate, totalOunces: calendarHomeVM.totalOunces)
            }
        }
        .padding()
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < -50 {
                        calendarHomeVM.changeMonth(by: 1)
                    } else if value.translation.width > 50 {
                        calendarHomeVM.changeMonth(by: -1)
                    }
                }
        )
        .animation(.easeInOut, value: calendarHomeVM.currentMonth)
        .onAppear {
            calendarHomeVM.setModelContext(modelContext)
            calendarHomeVM.fetchDrinkItemsForMonth()
        }
    }
}

//TODO: Toggle systemImage if on premium account or not
//Button("Add Previous Drink", systemImage: "lock") {
//                //            }
//            .buttonCapsule()
    
#Preview {
    CalendarView()
        .environment(CalendarHomeVM())
}
