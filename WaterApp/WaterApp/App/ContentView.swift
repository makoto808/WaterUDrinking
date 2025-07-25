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
    
    @EnvironmentObject var purchaseManager: PurchaseManager

    @State private var calendarHomeVM = CalendarHomeVM()
    @State private var drinkListVM = DrinkListVM()
    @State private var showGoalSetup: Bool = false
    
    @AppStorage("hasSeenGoalSetup") private var hasSeenGoalSetup: Bool = false

    var body: some View {
        NavigationStack(path: $drinkListVM.navPath) {
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
        .environment(drinkListVM)
        .onAppear {
            drinkListVM.modelContext = modelContext
            drinkListVM.refreshTodayItems(modelContext: modelContext)
            drinkListVM.loadUserGoal(context: modelContext)

            if !hasSeenGoalSetup {
                showGoalSetup = true
                hasSeenGoalSetup = true
            }
        }
        .onChange(of: purchaseManager.hasProAccess) { newValue, _ in
            print("💡 hasProAccess changed to \(newValue)")
        }
        .fullScreenCover(isPresented: $showGoalSetup) {
            GoalView(isOnboarding: true, drinkListVM: drinkListVM)
        }
    }
}
