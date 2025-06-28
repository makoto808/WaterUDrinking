//
//  CalendarDayCell.swift
//  WaterApp
//
//  Created by Gregg Abe on 6/24/25.
//

import SwiftUI

struct CalendarDayCell: View {
    let date: Date
    let isInMonth: Bool
    let isSelected: Bool
    let hasEvent: Bool
    let onSelect: () -> Void

    private var backgroundColor: Color {
        if isSelected { return .cyan }
        if hasEvent { return .blue }
        return .blue.opacity(0.2)
    }

    var body: some View {
        Group {
            if isInMonth {
                Text("\(Calendar.current.component(.day, from: date))")
                    .font(.custom("ArialRoundedMTBold", size: 15))
                    .frame(width: 35, height: 35)
                    .background(backgroundColor)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                    .onTapGesture {
                        onSelect()
                    }
            } else {
                Text("")
                    .frame(width: 35, height: 35)
            }
        }
    }
}
 
