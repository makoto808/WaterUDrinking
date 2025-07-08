//
//  ExtensionsText.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/25/25.
//

import SwiftUI

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

// MARK: - HomeView and TitleView

extension Text {
    func fontTitle() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 45))
            .foregroundStyle(.primary)
            .lineLimit(1)
            .allowsTightening(true)
            .minimumScaleFactor(0.30)
            .padding(.horizontal, 20)
    }
    
    func fontSubtitle() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 20))
            .foregroundStyle(.primary)
            .lineLimit(1)
            .allowsTightening(true)
            .minimumScaleFactor(0.30)
            .padding(.horizontal, 20)
    }
    
    func fontMediumTitle() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 35))
            .foregroundStyle(.primary)
            .lineLimit(1)
            .allowsTightening(true)
            .minimumScaleFactor(0.30)
            .padding(.horizontal, 20)
    }
    
    // MARK: - Small Titles
    
    func fontSmallTitle() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 16))
            .foregroundStyle(.primary)
            .fontWeight(.semibold)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
    
    func fontSmallTitle2() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 16))
            .foregroundStyle(.secondary)
            .fontWeight(.semibold)
            .lineLimit(1)
    }
    
    // MARK: - Custom Labels
    func fontOzLabel() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 40))
            .foregroundColor(.primary)
    }
    
    func fontBarLabel() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 23))
            .foregroundColor(.primary)
    }
    
    func fontBarLabel2() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 23))
            .foregroundColor(.secondary)
    }
    
    // MARK: - Goal and BarCharts
    func fontGoalLine() -> some View {
        self.font(.caption)
            .foregroundColor(.secondary)
    }
    
    func fontXAxis() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 12))
            .foregroundColor(.gray)
    }
}

// MARK: - TextField

extension TextField {
    func fontCustomOzViewTextField() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 40))
            .keyboardType(.decimalPad)
            .multilineTextAlignment(.trailing)
            .frame(width: 100)
    }
    
    func fontGoalViewTextField() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 40))
            .foregroundStyle(.primary)
            .frame(width: 250)
            .lineLimit(1)
            .allowsTightening(true)
            .minimumScaleFactor(0.30)
            .keyboardType(.decimalPad)
            .multilineTextAlignment(.center)
    }
}

extension View {
    func fontGoalViewTextField() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 40))
            .foregroundStyle(.primary)
            .frame(width: 250)
            .lineLimit(1)
            .allowsTightening(true)
            .minimumScaleFactor(0.30)
            .keyboardType(.decimalPad)
            .multilineTextAlignment(.center)
    }
    
    func alarmSetLabel() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 16))
            .foregroundStyle(.primary)
            .fontWeight(.semibold)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .padding(.vertical, 8)
    }
    
    func reminderTitle() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 18))
            .foregroundStyle(.primary)
    }
    
    func reminderTime() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 16))
            .foregroundStyle(.secondary)
    }
}
