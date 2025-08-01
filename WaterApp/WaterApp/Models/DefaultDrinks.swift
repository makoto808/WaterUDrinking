//
//  DefaultDrinks.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/30/25.
//

import Foundation

struct DefaultDrinks {
    static let all: [DrinkItem] = [
        DrinkItem(name: "Water", img: "waterBottle", volume: 0.0, hydrationRate: 100, category: .water),
        DrinkItem(name: "Tea", img: "tea", volume: 0.0, hydrationRate: 90, category: .tea),
        DrinkItem(name: "Coffee", img: "coffee", volume: 0.0, hydrationRate: 60, category: .coffee),
        DrinkItem(name: "Soda", img: "soda", volume: 0.0, hydrationRate: 70, category: .soda),
        DrinkItem(name: "Juice", img: "juice", volume: 0.0, hydrationRate: 80, category: .juice),
        DrinkItem(name: "Milk", img: "milk", volume: 0.0, hydrationRate: 85, category: .milk),
        DrinkItem(name: "Energy Drink", img: "energyDrink", volume: 0.0, hydrationRate: 60, category: .energy),
        DrinkItem(name: "Beer", img: "beer", volume: 0.0, hydrationRate: 50, category: .alcohol),
        DrinkItem(name: "Sparkling Water", img: "sparklingWater", volume: 0.0, hydrationRate: 100, category: .water),
        DrinkItem(name: "Electrolyte Water", img: "electrolyteWater", volume: 0.0, hydrationRate: 100, category: .water),
        DrinkItem(name: "Coconut Water", img: "coconutWater", volume: 0.0, hydrationRate: 100, category: .water),
        DrinkItem(name: "Sake", img: "sake", volume: 0.0, hydrationRate: 90, category: .alcohol),
        DrinkItem(name: "Soju", img: "soju", volume: 0.0, hydrationRate: 90, category: .alcohol),
        DrinkItem(name: "Red Wine", img: "redWine", volume: 0.0, hydrationRate: 90, category: .alcohol),
        DrinkItem(name: "White Wine", img: "whiteWine", volume: 0.0, hydrationRate: 90, category: .alcohol),
        DrinkItem(name: "Martini", img: "martini", volume: 0.0, hydrationRate: 90, category: .alcohol),
        DrinkItem(name: "Whiskey", img: "whiskey", volume: 0.0, hydrationRate: 90, category: .liquor)
        // Add more drinks here
    ]
}

