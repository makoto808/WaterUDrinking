//
//  CalendarView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/26/25.
//

import SwiftUI

struct CalendarView: View {
    @State private var currentMonth = Date()
    @State private var selectedDate: Date? = nil

    private let calendar: Calendar = {
        var cal = Calendar.current
        cal.firstWeekday = 1 // Sunday start
        return cal
    }()

    // Mocked event dates
    private let sampleEventDates: [Date] = {
        let today = Date()
        let calendar = Calendar.current
        return [
            today,
            calendar.date(byAdding: .day, value: -2, to: today)!,
            calendar.date(byAdding: .day, value: 3, to: today)!
        ]
    }()

    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    private let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    var body: some View {
        let dates = generateMonthDates(for: currentMonth)

        VStack {
            Text(monthYearFormatter.string(from: currentMonth))
                .font(.title)
                .padding()

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.gray)
                }
            }

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(dates, id: \.self) { date in
                    let isInCurrentMonth = calendar.isDate(date, equalTo: currentMonth, toGranularity: .month)
                    let isSelected = calendar.isDate(date, inSameDayAs: selectedDate ?? Date())
                    let hasEvent = sampleEventDates.contains { calendar.isDate($0, inSameDayAs: date) }

                    Group {
                        //TODO: Put a crown on date if 100% goal complete
                        if isInCurrentMonth {
                            Text(dayFormatter.string(from: date))
                                .frame(width: 35, height: 35)
                                .background(
                                    isSelected ? Color.cyan :
                                    hasEvent ? Color.blue :
                                    Color.blue.opacity(0.2)
                                )
                                .cornerRadius(8)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    selectedDate = date
                                }
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

            Spacer()
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

        let start = firstWeek.start
        let end = lastWeek.end

        var dates: [Date] = []
        var current = start

        while current < end {
            dates.append(current)
            guard let next = calendar.date(byAdding: .day, value: 1, to: current) else { break }
            current = next
        }

        return dates
    }
}

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
//            Button("Add Previous Drink", systemImage: "lock") {
//                //TODO: Toggle systemImage if on premium account or not
//            }
//            .buttonCapsule()
//        }
//        .padding(.horizontal)
//        .background(Color.backgroundWhite.ignoresSafeArea())
//    }
//}
