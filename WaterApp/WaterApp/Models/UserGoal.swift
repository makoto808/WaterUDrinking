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
    var id: String = "uniqueUserGoal"
    var goal: Double = 0.0

    init(goal: Double = 0.0, id: String = "uniqueUserGoal") {
        self.goal = goal
        self.id = id
    }
}
