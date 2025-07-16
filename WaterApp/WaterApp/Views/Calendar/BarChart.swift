//
//  BarChart.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/26/25.
//

import SwiftUI
import Charts
import SwiftData

struct BarChart: View {
    @Environment(DrinkListVM.self) private var drinkListVM
    @Environment(\.modelContext) private var modelContext
    
    @State private var weekOffset: Int = 0
    
    private var calendar = Calendar.current
    
    // MARK: - Week Dates (Sunday to Saturday)
    private var weekDates: [Date] {
        let today = calendar.startOfDay(for: Date())
        let weekday = calendar.component(.weekday, from: today) // Sunday = 1
        let daysSinceSunday = weekday - 1
        
        guard let thisWeekSunday = calendar.date(byAdding: .day, value: -daysSinceSunday, to: today),
              let targetSunday = calendar.date(byAdding: .day, value: weekOffset * 7, to: thisWeekSunday)
        else {
            return []
        }
        
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: targetSunday) }
    }
    
    // MARK: - Fetch Data from SwiftData
    private func fetchWeeklyData() -> [DayOfWeek] {
        var totals: [Date: Double] = [:]
        for day in weekDates {
            totals[day] = 0
        }
        
        let start = weekDates.first!
        let end = calendar.date(byAdding: .day, value: 7, to: start)!
        
        let predicate = #Predicate<CachedDrinkItem> {
            $0.date >= start && $0.date < end
        }
        
        let descriptor = FetchDescriptor<CachedDrinkItem>(predicate: predicate)
        
        do {
            let results = try modelContext.fetch(descriptor)
            for item in results {
                let day = calendar.startOfDay(for: item.date)
                if totals[day] != nil {
                    totals[day]! += item.volume
                }
            }
        } catch {
            print("Fetch failed: \(error)")
        }
        
        return weekDates.map { date in
            DayOfWeek(date: date, ouncesOfWater: Int(totals[date] ?? 0))
        }
    }
    
    var body: some View {
        let weeklyData = fetchWeeklyData()
        
        VStack(spacing: 8) {
            Text("Daily Water Consumed")
                .fontBarLabel()
            
            Chart {
                RuleMark(y: .value("Goal", drinkListVM.totalOzGoal))
                    .foregroundStyle(Color.mint)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [10]))
                    .annotation(alignment: .leading) {
                        Text("Goal").fontXAxis()
                    }
                
                ForEach(weeklyData) { day in
                    BarMark(
                        x: .value("Day", day.weekdayLabel),
                        y: .value("Ounces", day.ouncesOfWater)
                    )
                }
                .foregroundStyle(Color.cyan.gradient)
                .cornerRadius(4)
            }
            .chartXAxis {
                AxisMarks(values: weeklyData.map { $0.weekdayLabel }) { value in
                    AxisValueLabel(centered: true) {
                        if let str = value.as(String.self) {
                            Text(str)
                                .fontXAxis()
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .chartYAxis {
                AxisMarks(position: .trailing) { value in
                    AxisValueLabel() {
                        if let y = value.as(Double.self) {
                            Text("\(Int(y))")
                                .fontXAxis()
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .frame(height: 220)
        }
        .padding(.horizontal)
        .animation(.easeIn, value: weekOffset)
        .gesture(
            DragGesture()
                .onEnded { value in
                    withAnimation(.easeIn) {
                        if value.translation.width < -50 {
                            weekOffset += 1
                        } else if value.translation.width > 50 {
                            weekOffset -= 1
                        }
                    }
                }
        )
        .background(Color("AppBackgroundColor")).ignoresSafeArea()
    }
}

#Preview {
    let vm = DrinkListVM()
    vm.totalOzGoal = 64
    return BarChart()
        .environment(vm)
}

// MARK: - Support Structs

struct DayOfWeek: Identifiable {
    let id = UUID()
    let date: Date
    let ouncesOfWater: Int
    
    var weekdayLabel: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "M/d" // shows as "6/21"
        return formatter.string(from: date)
    }
}
    
    //
    //    var weekdayLabel: String {
    //        let formatter = DateFormatter()
    //        formatter.locale = Locale(identifier: "en_US")
    //        formatter.dateFormat = "EEE" // "Sun", "Mon", ...
    //        return formatter.string(from: date)
    //
