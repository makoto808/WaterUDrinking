//
//  DrinkItem.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/2/25.
//

import Foundation
import SwiftData

// NOTE: Used to display in DrinkSelectionView.
struct DrinkItem: Identifiable, Hashable {
    var id: String
    var name: String
    var img: String
    var volume: Double
    var hydrationRate: Int
    var category: DrinkCategory
    
    init(name: String, img: String, volume: Double, hydrationRate: Int, category: DrinkCategory) {
        self.id = UUID().uuidString
        self.name = name
        self.img = img
        self.volume = volume
        self.hydrationRate = hydrationRate
        self.category = category
    }
    
    init(_ cached: CachedDrinkItem) {
        self.id = cached.id
        self.name = cached.name
        self.img = cached.img
        self.volume = cached.volume
        self.hydrationRate = cached.hydrationRate
        self.category = cached.category
    }
}

// NOTE: Used to cache the drink data
@Model
class CachedDrinkItem: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var date: Date = Date()
    var name: String = ""
    var img: String = ""
    var volume: Double = 0.0
    var hydrationRate: Int = 100 // ← Add this
    var categoryRaw: String = DrinkCategory.water.rawValue // or any valid default, like .coffee


    var arrayOrderValue: Int = 0

    // Computed property for real category enum
    var category: DrinkCategory {
        get { DrinkCategory(rawValue: categoryRaw)! } // force unwrap is safe here
        set { categoryRaw = newValue.rawValue }
    }

    init(
        date: Date = Date(),
        name: String = "",
        img: String = "",
        volume: Double = 0.0,
        hydrationRate: Int = 100,
        category: DrinkCategory = .water,
        arrayOrderValue: Int = 0
    ) {
        self.id = UUID().uuidString
        self.date = date
        self.name = name
        self.img = img
        self.volume = volume
        self.hydrationRate = hydrationRate
        self.categoryRaw = category.rawValue
        self.arrayOrderValue = arrayOrderValue
    }

    init(_ item: DrinkItem) {
        self.id = item.id
        self.date = Date()
        self.name = item.name
        self.img = item.img
        self.volume = item.volume
        self.hydrationRate = item.hydrationRate
        self.categoryRaw = item.category.rawValue
        self.arrayOrderValue = 0
    }

    static func == (lhs: CachedDrinkItem, rhs: CachedDrinkItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
