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

extension Text {
    func fontTitle() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 45))
            .foregroundStyle(.primary)
            .lineLimit(1)
            .allowsTightening(true)
            .minimumScaleFactor(0.30)
            .padding(.horizontal, 20)
    }
    
    func fontSmall() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 20))
            .foregroundStyle(.primary)
            .lineLimit(1)
            .allowsTightening(true)
            .minimumScaleFactor(0.30)
            .padding(.horizontal, 20)
    }
    
    func fontGoalViewTitle() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 45))
            .foregroundStyle(.primary)
            .lineLimit(1)
            .allowsTightening(true)
            .minimumScaleFactor(0.30)
            .padding(.horizontal, 5)
    }
    
    //Fonts for CustomDrinkView
    func fontCustomDrinkViewTitle() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 16))
            .fontWeight(.semibold)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
    
    func fontCustomDrinkViewSubtitle() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 16))
            .font(.subheadline)
            .foregroundColor(.secondary)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
    
    func fontOzLabel() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 40))
            .foregroundColor(.primary)
    }
    
    func fontBarLabel() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 23))
            .foregroundColor(.primary)
    }
    func fontGoalLine() -> some View {
        self.font(.caption)
            .foregroundColor(.secondary)
    }
}

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
