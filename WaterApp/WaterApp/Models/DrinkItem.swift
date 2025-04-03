//
//  DrinkItem.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/2/25.
//

import Foundation

struct DrinkItem: Identifiable {
    let id = UUID().uuidString
    let name: String
    let img: String
}
