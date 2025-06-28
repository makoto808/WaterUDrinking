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
        }
        .modelContainer(for: [CachedDrinkItem.self, UserGoal.self])
    }
}

/*
 //TODO:
 - Add SwiftData too BarChart
 - Add Button to add/delete data from CalendarView
    - Allow tapping a drink to edit or delete?
 - If user goal is met, show crown on calendar date
 - Add haptic touch
 - Add sound effects?
 
 Refactor branch
 - clean up extensions
 - break down code into smaller sizes
 - move to CalendarVM
 */
