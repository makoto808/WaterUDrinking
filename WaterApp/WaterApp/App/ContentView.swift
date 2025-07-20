//
//  ContentView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/22/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(NotificationVM.self) private var notificationVM

    @State private var drinkListVM = DrinkListVM()
    @State private var calendarHomeVM = CalendarHomeVM()
    
    let purchaseManager: PurchaseManager

    var body: some View {
        NavigationStack(path: $drinkListVM.navPath) {
            HomeView()
                .navigationDestination(for: NavPath.self) { navPath in
                    switch navPath {
                    case .calendar:
                        CalendarHomeView(purchaseManager: purchaseManager)
                            .environment(calendarHomeVM)
                    case .settings:
                        SettingsListView()
                    case .drinkFillView(let drink):
                        DrinkFillView(item: drink)
                    case .dailyWaterGoal:
                        GoalView()
                    case .resetView:
                        ResetView()
                    case .purchaseView:
                        PurchaseView()
                    case .notificationView:
                        NotificationView()
                    case .lightDarkModeView:
                        LightDarkModeView()
                    default:
                        EmptyView()
                    }
                }
        }
        .environment(drinkListVM)
        .onAppear {
            drinkListVM.loadFromCache(modelContext)
            drinkListVM.loadUserGoal(context: modelContext)
        }
        // Add this to update the view when hasProAccess changes
        .onChange(of: purchaseManager.hasProAccess) { newValue, oldValue in
            // React to change, have both new and old values if needed
        }
    }
}
