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
    @State private var drinkMenuVM: DrinkMenuVM
    @State private var drinkListVM: DrinkListVM

    @AppStorage("selectedAppearance") private var selectedAppearance: String = AppColorScheme.system.rawValue
    @AppStorage("lastSyncDate") private var lastSyncDate: Double = 0

    let modelContainer: ModelContainer

    init() {
        do {
            let schema = Schema([
                CachedDrinkItem.self,
                UserGoal.self,
                NotificationModel.self,
                UserArrangedDrinkItem.self
            ])

            let config = ModelConfiguration(
                "WaterAppData",
                schema: schema,
                cloudKitDatabase: .private("iCloud.com.greggyphenom.waterapp")
            )
            let container = try ModelContainer(for: schema, configurations: [config])
            
            // Initialize VMs with model context
            _notificationVM = State(wrappedValue: NotificationVM(context: container.mainContext))
            _drinkMenuVM = State(wrappedValue: DrinkMenuVM(context: container.mainContext))
            
            let listVM = DrinkListVM()
            listVM.modelContext = container.mainContext
            _drinkListVM = State(wrappedValue: listVM)

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
                .environment(drinkMenuVM)
                .environment(drinkListVM)
                .environmentObject(purchaseManager)
                .task {
                    await purchaseManager.updatePurchaseStatus()
                    purchaseManager.listenForUpdates()
                    
                    // Load user drinks and sync defaults on launch
                    drinkListVM.loadUserDrinkItems(modelContainer.mainContext)
                    drinkListVM.syncDefaultDrinks()
                }
        }
    }
}
