//
//  UserArrangedDrinkItem.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/26/25.
//

import Foundation
import SwiftData

@Model
class UserArrangedDrinkItem: Identifiable, Hashable {
    var id: String = UUID().uuidString
    
    var name: String = ""
    var img: String = ""
    var arrayOrderValue: Int = 0 

    init(name: String = "", img: String = "", arrayOrderValue: Int = 0) {
        self.name = name
        self.img = img
        self.arrayOrderValue = arrayOrderValue
    }

    static func == (lhs: UserArrangedDrinkItem, rhs: UserArrangedDrinkItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
