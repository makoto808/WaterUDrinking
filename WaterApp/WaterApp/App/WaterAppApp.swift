//
//  WaterAppApp.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/22/25.
//

import CloudKit
import SwiftData
import SwiftUI

@main
struct WaterAppApp: App {
    @StateObject private var purchaseManager = PurchaseManager.shared
    @State private var notificationVM: NotificationVM

    @AppStorage("selectedAppearance") private var selectedAppearance: String = AppColorScheme.system.rawValue
    @AppStorage("lastSyncDate") private var lastSyncDate: Double = 0

    let modelContainer: ModelContainer
 
    init() {
        do {
            let schema = Schema([CachedDrinkItem.self, UserGoal.self, NotificationModel.self])
            let config = ModelConfiguration(
                "WaterAppData",
                schema: schema,
                cloudKitDatabase: .private("iCloud.com.greggyphenom.waterapp")
            )
            let container = try ModelContainer(for: schema, configurations: [config])
            _notificationVM = State(wrappedValue: NotificationVM(context: container.mainContext))
            self.modelContainer = container
        } catch {
            fatalError("Failed to create model container: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(AppColorScheme(rawValue: selectedAppearance)?.colorScheme)
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

