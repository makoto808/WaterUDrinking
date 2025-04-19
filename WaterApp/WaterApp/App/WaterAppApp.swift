//
//  WaterAppApp.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/22/25.
//

import SwiftUI
import SwiftData

@main
struct WaterAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: DrinkItem.self)
    }
}
