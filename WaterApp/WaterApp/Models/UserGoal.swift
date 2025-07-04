//
//  UserGoal.swift
//  WaterApp
//
//  Created by Gregg Abe on 6/21/25.
//

import Foundation
import SwiftData

@Model
class UserGoal {
    @Attribute(.unique) var id: String
    var goal: Double
    
    init(goal: Double, id: String = "uniqueUserGoal") {
        self.goal = goal
        self.id = id
    }
}
