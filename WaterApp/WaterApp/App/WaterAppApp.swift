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
    @AppStorage("selectedAppearance") private var selectedAppearance: String = AppColorScheme.system.rawValue

    @State private var notificationVM: NotificationVM
    @State private var purchaseManager = PurchaseManager.shared

    let modelContainer: ModelContainer

    init() {
        do {
            let container = try ModelContainer(for: CachedDrinkItem.self, UserGoal.self, NotificationModel.self)
            _notificationVM = State(wrappedValue: NotificationVM(context: container.mainContext))
            self.modelContainer = container
        } catch {
            fatalError("Failed to create model container: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView(purchaseManager: purchaseManager)
                .preferredColorScheme(AppColorScheme(rawValue: selectedAppearance)?.colorScheme)
                .modelContainer(modelContainer)
                .environment(notificationVM)
                .task {
                    await purchaseManager.updatePurchaseStatus()
                    purchaseManager.listenForUpdates()
                }
        }
    }
}
