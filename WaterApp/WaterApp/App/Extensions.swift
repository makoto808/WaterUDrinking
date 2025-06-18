//
//  Extensions.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/26/25.
//

import SwiftUI

extension Color {
    static let backgroundWhite = Color(red: 0.9373, green: 0.9607, blue: 0.9607)
}

extension Image {
    func CDVresize() -> some View {
        self.resizable()
            .scaledToFit()
            .frame(height: 70)
            .cornerRadius(4)
    }
}

extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(limit))
            }
        }
        return self
    }
}

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}

extension View {
    func drinkFilllViewButtonStyle(maxWidth: CGFloat = .infinity) -> some View {
        self
            .buttonBorderShape(.capsule)
            .buttonStyle(.borderedProminent)
            .font(.custom("ArialRoundedMTBold", size: 25))
            .frame(maxWidth: 170)
            .lineLimit(1)
            .allowsTightening(true)
            .minimumScaleFactor(0.30)
            .textCase(.uppercase)
    }
    
    func button1(maxWidth: CGFloat = .infinity) -> some View {
        self.buttonBorderShape(.capsule)
            .buttonStyle(.borderedProminent)
            .font(.custom("ArialRoundedMTBold", size: 20))
    }
    
    func button2(maxWidth: CGFloat = .infinity) -> some View {
        self.buttonBorderShape(.capsule)
            .buttonStyle(.borderedProminent)
            .font(.custom("ArialRoundedMTBold", size: 25))
            .textCase(.uppercase)
    }
}
