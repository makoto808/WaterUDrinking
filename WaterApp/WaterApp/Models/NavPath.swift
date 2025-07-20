//
//  NavPath.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/11/25.
//

import Foundation

enum NavPath: Hashable {
    case calendar
    case settings
    case drinkFillView(DrinkItem)
    case dailyWaterGoal
    case resetView
    case purchaseView
    case notificationView
    case notificationAlarm
    case lightDarkModeView
}
