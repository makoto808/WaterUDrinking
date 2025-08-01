//
//  NavPath.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/11/25.
//

import Foundation

enum NavPath: Hashable {
    case calendar
    case cloudSync
    case dailyWaterGoal
    case disclaimer
    case drinkFillView(DrinkItem)
    case drinkMenuView
    case ideaCenterView
    case lightDarkModeView
    case notificationAlarm
    case notificationView
    case purchaseView
    case resetView
    case settings
}
