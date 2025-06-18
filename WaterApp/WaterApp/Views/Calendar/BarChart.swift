//
//  BarChart.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/26/25.
//

import SwiftUI
import Charts

struct BarChart: View { //TODO: Data for previous days (weekly view)
    
    let viewDay: [ViewDay] = [ //sample data
        .init(date: Date.from(year: 2025, day: 1), ouncesOfWater: 30),
        .init(date: Date.from(year: 2025, day: 2), ouncesOfWater: 55),
        .init(date: Date.from(year: 2025, day: 3), ouncesOfWater: 36),
        .init(date: Date.from(year: 2025, day: 4), ouncesOfWater: 81),
        .init(date: Date.from(year: 2025, day: 5), ouncesOfWater: 36),
        .init(date: Date.from(year: 2025, day: 6), ouncesOfWater: 41),
        .init(date: Date.from(year: 2025, day: 7), ouncesOfWater: 29)
    ]
    
    var body: some View {
        VStack {
            Text("Daily Water Intake")
                .fontBarLabel()
            
            Chart {
                RuleMark(y: .value("Goal", 64))
                    .foregroundStyle(Color.mint)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [10]))
                    .annotation(alignment: .leading) {
                        Text("Goal")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                
                ForEach(viewDay) { viewDay in
                    BarMark(
                        x: .value("Day", viewDay.date, unit: .day),
                        y: .value("Ounces of Water", viewDay.ouncesOfWater))
                }
                .foregroundStyle(Color.cyan.gradient)
                .cornerRadius(5)
            }
        }
        .frame(height: 270)
        .chartXAxis {
            AxisMarks(values: viewDay.map { $0.date }) { date in
                AxisValueLabel(format: .dateTime.day(), centered: true)
                }
            }
        .background(Color.backgroundWhite.ignoresSafeArea())
        }
    }

#Preview {
    BarChart()
}

struct ViewDay: Identifiable {
    let id = UUID()
    let date: Date
    let ouncesOfWater: Int
}

extension Date {
    static func from(year: Int, day: Int) -> Date {
        let components = DateComponents(year: year, day: day)
        return Calendar.current.date(from: components)!
    }
}
