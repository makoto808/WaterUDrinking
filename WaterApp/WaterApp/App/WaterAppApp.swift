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
    @State private var notificationVM: NotificationVM
    @StateObject private var purchaseManager = PurchaseManager.shared

    init() {
        do {
            let container = try ModelContainer(for: CachedDrinkItem.self, UserGoal.self, NotificationModel.self)
            _notificationVM = State(wrappedValue: NotificationVM(context: container.mainContext))
            self.modelContainer = container
        } catch {
            fatalError("Failed to create model container: \(error)")
        }
    }

    let modelContainer: ModelContainer

    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
                .environment(notificationVM)
                .environmentObject(purchaseManager)
                .task {
                    await purchaseManager.updatePurchaseStatus()
                    purchaseManager.listenForUpdates()
                }
        }
    }
}
