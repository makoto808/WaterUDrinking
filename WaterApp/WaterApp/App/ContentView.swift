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
    @Environment(DrinkListVM.self) private var drinkListVM

    @EnvironmentObject var purchaseManager: PurchaseManager

    @State private var calendarHomeVM = CalendarHomeVM()
    @State private var showGoalSetup: Bool = false

    @AppStorage("hasSeenGoalSetup") private var hasSeenGoalSetup: Bool = false

    var body: some View {
        NavigationStack(path: Binding(
            get: { drinkListVM.navPath },
            set: { drinkListVM.navPath = $0 }
        )) {
            HomeView()
                .navigationDestination(for: NavPath.self) { navPath in
                    switch navPath {
                    case .calendar:
                        CalendarHomeView()
                            .environment(calendarHomeVM)
                    case .cloudSync:
                        CloudSync()
                    case .dailyWaterGoal:
                        GoalView(drinkListVM: drinkListVM)
                    case .drinkFillView(let drink):
                        DrinkFillView(item: drink)
                    case .drinkMenuView:
                        DrinkMenuView()
                    case .ideaCenterView:
                        IdeaCenterView()
                    case .lightDarkModeView:
                        LightDarkModeView()
                    case .notificationView:
                        NotificationView()
                    case .purchaseView:
                        PurchaseView()
                    case .resetView:
                        ResetView()
                    case .settings:
                        SettingsListView()
                    default:
                        EmptyView()
                    }
                }
        }
        .onAppear {
            drinkListVM.modelContext = modelContext
            drinkListVM.refreshTodayItems(modelContext: modelContext)
            drinkListVM.loadUserGoal(context: modelContext)

            // Remove this line because navPath is now bound directly
            // navPath = drinkListVM.navPath

            if !hasSeenGoalSetup {
                showGoalSetup = true
                hasSeenGoalSetup = true
            }
        }
        // Remove this onChange because navPath is no longer a local @State
        // .onChange(of: navPath) {
        //     drinkListVM.navPath = navPath
        // }
        .onChange(of: purchaseManager.hasProAccess) { oldValue, newValue in
            print("Changed from \(oldValue) to \(newValue)")
        }
        .fullScreenCover(isPresented: $showGoalSetup) {
            GoalView(isOnboarding: true, drinkListVM: drinkListVM)
        }
    }
}
