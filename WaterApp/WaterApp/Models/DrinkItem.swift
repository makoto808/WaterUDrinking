//
//  DrinkItem.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/2/25.
//

import Foundation
import SwiftData

// NOTE: Used this to display in DrinkSelectionView.
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

    init(_ cached: CachedDrinkItem) {
        self.id = cached.id
        self.name = cached.name
        self.img = cached.img
        self.volume = cached.volume
    }
}

// NOTE: Used to cache the drink data
@Model class CachedDrinkItem: Identifiable, Hashable {
    var id: String
    var date: Date
    var name: String
    var img: String
    var volume: Double
    var arrayOrderValue: Int

    init(date: Date, name: String, img: String, volume: Double, arrayOrderValue: Int) {
        self.id = UUID().uuidString
        self.date = date
        self.name = name
        self.img = img
        self.volume = volume
        self.arrayOrderValue = arrayOrderValue
    }

    init(_ item: DrinkItem) {
        self.id = item.id
        self.date = .now
        self.name = item.name
        self.img = item.img
        self.volume = item.volume
        self.arrayOrderValue = 0
    }
}
