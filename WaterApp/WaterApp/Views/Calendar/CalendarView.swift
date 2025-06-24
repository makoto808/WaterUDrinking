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
    @State private var drinkItems: [CachedDrinkItem] = []
    @State private var currentMonth = Date()
    @State private var selectedDate: Date? = nil
    
    // Create a Set of just the day components from drink entries
    private var drinkDates: Set<Date> {
        Set(drinkItems.map { calendar.startOfDay(for: $0.date) })
    }
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    private let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    private let calendar: Calendar = {
        var cal = Calendar.current
        cal.firstWeekday = 1 // Sunday
        return cal
    }()

    var body: some View {
        let dates = generateMonthDates(for: currentMonth)

        VStack {
            Text(monthYearFormatter.string(from: currentMonth))
                .fontBarLabel()
                .padding()

            //NOTE: Weekday labels
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .fontCustomDrinkViewTitle()
                        .foregroundColor(.gray)
                }
            }

            //NOTE: Day grid
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(dates, id: \.self) { date in
                    let isInMonth = calendar.isDate(date, equalTo: currentMonth, toGranularity: .month)
                    let isSelected = calendar.isDate(date, inSameDayAs: selectedDate ?? Date())
                    let hasEvent = drinkDates.contains(calendar.startOfDay(for: date))

                    Group {
                        if isInMonth {
                            Text(dayFormatter.string(from: date))
                                .frame(width: 35, height: 35)
                                .background(
                                    isSelected ? Color.cyan :
                                    hasEvent ? Color.blue :
                                    Color.blue.opacity(0.2)
                                )
                                .cornerRadius(20)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    selectedDate = date
                                }
                        } else {
                            Text("")
                                .frame(width: 35, height: 35)
                        }
                    }
                }
            }
            
            // Drink list appears only if there's data for the selected date
            if let selectedDate = selectedDate,
               !drinksForSelectedDate.isEmpty {

                VStack(alignment: .leading, spacing: 8) {
                    Text("Total: \(totalOunces, specifier: "%.0f") oz")
                        .font(.headline)
                        .padding(.top)

                    ForEach(drinksForSelectedDate, id: \.id) { drink in
                        HStack(spacing: 12) {
                            Image(drink.img)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.blue)

                            VStack(alignment: .leading) {
                                Text(drink.name)
                                    .font(.subheadline)
                                Text("\(drink.volume, specifier: "%.0f") oz")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }

                            Spacer()
                        }
                        .padding(.vertical, 4)
                    }
                }
                .padding(.top)
            }
        }
        .padding()
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < -50 {
                        changeMonth(by: 1)
                    } else if value.translation.width > 50 {
                        changeMonth(by: -1)
                    }
                }
        )
        .animation(.easeInOut, value: currentMonth)
        .onChange(of: currentMonth) {
            updateDrinkQuery()
        }
        .onAppear {
            updateDrinkQuery()
        }
    }

    private func updateDrinkQuery() {
        let start = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth))!
        let end = calendar.date(byAdding: .month, value: 1, to: start)!
        let descriptor = FetchDescriptor<CachedDrinkItem>(
            predicate: #Predicate { $0.date >= start && $0.date < end }
        )
        do {
            drinkItems = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to fetch drink items: \(error)")
        }
    }

    private func changeMonth(by value: Int) {
        if let newMonth = calendar.date(byAdding: .month, value: value, to: currentMonth) {
            currentMonth = newMonth
        }
    }

    private var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }

    private var monthYearFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }

    private func generateMonthDates(for month: Date) -> [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: month),
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
    
    private var drinksForSelectedDate: [CachedDrinkItem] {
        guard let selectedDate else { return [] }
        return drinkItems.filter {
            calendar.isDate($0.date, inSameDayAs: selectedDate)
        }.sorted { $0.arrayOrderValue < $1.arrayOrderValue }
    }

    private var totalOunces: Double {
        drinksForSelectedDate.reduce(0) { $0 + $1.volume }
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

//import SwiftUI
//
//struct CalendarView: View {
//    //TODO: Access previous water data, show list of drinks consumed, show CupView of that day.
//    @Environment(CalendarHomeVM.self) private var vm
//    
//    @State private var date = Date()
//    
//    var body: some View {
//        VStack {
//            DatePicker(
//                "Start Date",
//                selection: $date,
//                displayedComponents: [.date]
//            )
//            .datePickerStyle(.graphical)
//            
//
//        }
//        .padding(.horizontal)
//        .background(Color.backgroundWhite.ignoresSafeArea())
//    }
//}
