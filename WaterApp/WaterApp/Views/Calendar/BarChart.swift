//
//  BarChart.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/26/25.
//

import SwiftUI
import Charts

struct BarChart: View {
    
    let viewMonths: [ViewMonth] = [
        .init(date: Date.from(year: 2025, month: 1, day: 1), viewCount: 30),
        .init(date: Date.from(year: 2025, month: 2, day: 1), viewCount: 55),
        .init(date: Date.from(year: 2025, month: 3, day: 1), viewCount: 24),
        .init(date: Date.from(year: 2025, month: 4, day: 1), viewCount: 64),
        .init(date: Date.from(year: 2025, month: 5, day: 1), viewCount: 36),
        .init(date: Date.from(year: 2025, month: 6, day: 1), viewCount: 41),
        .init(date: Date.from(year: 2025, month: 7, day: 1), viewCount: 29)
    ]
    
    
    var body: some View {
        VStack {
            Chart {
                ForEach(viewMonths) { viewMonth in
                    BarMark(
                        x: .value("Month", viewMonth.date, unit: .month),
                        y: .value("Views", viewMonth.viewCount))
                }
                .foregroundStyle(Color.cyan.gradient)
            }
        }
        .frame(height: 180)
    }
}

#Preview {
    BarChart()
}

struct ViewMonth: Identifiable {
    let id = UUID()
    let date: Date
    let viewCount: Int
}

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
}
