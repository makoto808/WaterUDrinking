//
//  DrinkItem.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/2/25.
//

import Foundation
import SwiftData

/// Use this to display in DrinkSelectionView
struct DrinkItem: Identifiable, Hashable {
    var id: String
    var name: String
    var img: String
    var volume: Double
    
    init(name: String, img: String, volume: Double) {
        self.id = UUID().uuidString
        self.name = name
        self.img = img
        self.volume = volume
    }
}

@Model class CachedDailyTotal: Identifiable, Hashable {
    var id: String
    var date: Date
    var volume: Double
    
    init(date: Date, volume: Double) {
        self.id = UUID().uuidString
        self.date = date
        self.volume = volume
    }
    
    init(_ drinkItem: DrinkItem) {
        self.id = drinkItem.id
        self.date = .now
        self.volume = drinkItem.volume
    }
}
