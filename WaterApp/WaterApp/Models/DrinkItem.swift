//
//  DrinkItem.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/2/25.
//

import Foundation

struct DrinkItem: Identifiable, Hashable {
    let id = UUID().uuidString
    var name: String
    var img: String
    var volume: Double
}
