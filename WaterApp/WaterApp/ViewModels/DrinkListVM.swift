//
//  DrinkListVM.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/2/25.
//

import Foundation
import Observation

@Observable final class DrinkListVM {
    var navPath: [NavPath] = [] //ryan lesson 146
    
    var items: [DrinkItem] = [
        DrinkItem(name: "Water", img: "waterBottle", volume: 0.0),
        DrinkItem(name: "Tea", img: "tea", volume: 0.0),
        DrinkItem(name: "Coffee", img: "coffee", volume: 0.0),
        DrinkItem(name: "Soda", img: "soda", volume: 0.0),
        DrinkItem(name: "Juice", img: "juice", volume: 0.0),
        DrinkItem(name: "Milk", img: "milk", volume: 0.0),
        DrinkItem(name: "Energy Drink", img: "energyDrink", volume: 0.0),
        DrinkItem(name: "Beer", img: "beer", volume: 0.0)
    ] {
        didSet {
            let sum = items.reduce(0.0) { $0 + ($1.volume + Double($1.volume))
            }
            totalOz = sum
        }
    }
    
    var totalOz: Double = 0.0
}

//@State private var drinkImage: [String] = ["waterBottle", "tea", "coffee", "soda", "juice", "milk", "energyDrink", "beer"]
//@State private var drinkName: [String] = ["Water", "Tea", "Coffee", "Soda", "Juice", "Milk", "Energy Drink", "Beer"]
