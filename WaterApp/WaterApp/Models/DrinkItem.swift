//
//  DrinkItem.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/2/25.
//

import Foundation
import SwiftData

@Model
class DrinkItem: Identifiable, Hashable {
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
