//
//  DefaultDrinks.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/30/25.
//

import Foundation

struct DefaultDrinks {
    static let all: [DrinkItem] = [
        // WATERS
        DrinkItem(name: "Water", img: "waterBottle", volume: 0.0, hydrationRate: 100, category: .water),
        DrinkItem(name: "Sparkling Water", img: "sparklingWater", volume: 0.0, hydrationRate: 100, category: .water),
        DrinkItem(name: "Electrolyte Water", img: "electrolyteWater", volume: 0.0, hydrationRate: 105, category: .water),
        DrinkItem(name: "Coconut Water", img: "coconutWater", volume: 0.0, hydrationRate: 100, category: .water),
        
        // TEAS
        DrinkItem(name: "Tea", img: "tea", volume: 0.0, hydrationRate: 90, category: .tea),
        
        // COFFEES
        DrinkItem(name: "Coffee", img: "coffee", volume: 0.0, hydrationRate: 70, category: .coffee),
        
        // SODAS
        DrinkItem(name: "Soda", img: "soda", volume: 0.0, hydrationRate: 80, category: .soda),
//        DrinkItem(name: "Diet Soda", img: "dietSoda", volume: 0.0, hydrationRate: 80, category: .soda),
//        DrinkItem(name: "Non-Caffeinated Soda", img: "nonCaffeinatedSoda", volume: 0.0, hydrationRate: 90, category: .soda),
        
        // JUICES
        DrinkItem(name: "Juice", img: "juice", volume: 0.0, hydrationRate: 90, category: .juice),
        
        // MILKS
        DrinkItem(name: "Milk", img: "milk", volume: 0.0, hydrationRate: 130, category: .milk),
        
        // ENERGY DRINKS
        DrinkItem(name: "Energy Drink", img: "energyDrink", volume: 0.0, hydrationRate: 85, category: .energy),
        
        // ALCOHOL
        DrinkItem(name: "Beer", img: "beer", volume: 0.0, hydrationRate: 70, category: .alcohol),
        DrinkItem(name: "Red Wine", img: "redWine", volume: 0.0, hydrationRate: 50, category: .alcohol),
        DrinkItem(name: "White Wine", img: "whiteWine", volume: 0.0, hydrationRate: 50, category: .alcohol),
        DrinkItem(name: "Sake", img: "sake", volume: 0.0, hydrationRate: 40, category: .alcohol),
        DrinkItem(name: "Soju", img: "soju", volume: 0.0, hydrationRate: 40, category: .alcohol),
        
        // LIQUOR
        DrinkItem(name: "Whiskey", img: "whiskey", volume: 0.0, hydrationRate: -150, category: .liquor),
        DrinkItem(name: "Martini", img: "martini", volume: 0.0, hydrationRate: -120, category: .liquor)
        
        // Add more drinks here
    ]
}

/* NOTES:
40% ABV would be -150 hydrationRate
 mixed drinks can be -120
 
 beers will be 70
 strong beers will be 60
 
 20% ABV will be 40
*/

/* MARK: - Future Drink Ideas?

 Yerba Mate
 Matcha
 Iced Tea
 Boba Tea
 Kombucha
 
 Hot Cocoa
 
 Soy Milk
 Almond Milk
 Oat Milk
 
 //        DrinkItem(name: "Diet Soda", img: "dietSoda", volume: 0.0, hydrationRate: 80, category: .soda),
 //        DrinkItem(name: "Non-Caffeinated Soda", img: "nonCaffeinatedSoda", volume: 0.0, hydrationRate: 90, category: .soda),
*/
