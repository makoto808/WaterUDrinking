//
//  WaterAppApp.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/22/25.
//

import SwiftData
import SwiftUI

@main
struct WaterAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [CachedDrinkItem.self, UserGoal.self, NotificationModel.self])
        }
    }
}

/*
 // TODO:
 - Add SwiftData too BarChart
 - Add haptic touch?
 - Add sound effects?
 
 - Change toolbar back button. remove BACK and just keep back arrow
 */
