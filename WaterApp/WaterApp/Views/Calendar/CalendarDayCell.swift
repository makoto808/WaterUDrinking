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
    let goalMet: Bool
    let onSelect: () -> Void
    
    private var backgroundColor: Color {
        if isSelected { return .cyan }
        if hasEvent { return .blue }
        return .blue.opacity(0.2)
    }
    
    var body: some View {
        Group {
            if !isInMonth {
                Color.clear.frame(width: 35, height: 35)
            } else if goalMet {
                Image("waterBottle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .frame(width: 35, height: 35)
                    .background(backgroundColor)
                    .cornerRadius(20)
                    .foregroundColor(.white)
            } else {
                Text("\(Calendar.current.component(.day, from: date))")
                    .font(.custom("ArialRoundedMTBold", size: 15))
                    .frame(width: 35, height: 35)
                    .background(backgroundColor)
                    .cornerRadius(20)
                    .foregroundColor(.white)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if isInMonth {
                onSelect()
            }
        }
    }
}
