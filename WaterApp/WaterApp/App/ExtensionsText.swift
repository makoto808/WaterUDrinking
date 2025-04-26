//
//  ExtensionsText.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/25/25.
//

import Foundation
import SwiftUI

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension Text {
    func titleFont() -> some View {
        self.font(.custom("ArialRoundedMTBold", size: 45))
            .lineLimit(1)
            .allowsTightening(true)
            .minimumScaleFactor(0.30)
            .padding(.horizontal, 20)
    }
}
