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

@Model class CachedDrinkItem: Identifiable, Hashable {
    var id: String
    var date: Date
    var name: String
    var img: String
    var volume: Double
    
    init(date: Date, name: String, img: String, volume: Double) {
        self.id = UUID().uuidString
        self.date = date
        self.name = name
        self.img = img
        self.volume = volume
    }
    
    init(_ drinkItem: DrinkItem) {
        self.id = drinkItem.id
        self.date = .now
        self.name = drinkItem.name
        self.img = drinkItem.img
        self.volume = drinkItem.volume
    }
}
