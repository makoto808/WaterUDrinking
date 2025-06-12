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
    func titleFont() -> some View {
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
    
    //Fonts for CustomDrinkView
    func fontCDVTitle() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 16))
            .fontWeight(.semibold)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
    
    func fontCDVSubtitle() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 16))
            .font(.subheadline)
            .foregroundColor(.secondary)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
    }
}
