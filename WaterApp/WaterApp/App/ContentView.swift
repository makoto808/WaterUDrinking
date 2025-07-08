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
    @AppStorage("isProUnlocked") private var isProUnlocked = false

    
    var body: some View {
        NavigationStack(path: $drinkListVM.navPath) {
            HomeView()  // no isProUnlocked param here
                .navigationDestination(for: NavPath.self) { navPath in
                    switch navPath {
                    case .calendar:
                        CalendarHomeView()
                            .environment(calendarHomeVM)
                    case .settings:
                        SettingsListView()
                    case .drinkFillView(let drink):
                        DrinkFillView(item: drink)
                    case .dailyWaterGoal:
                        GoalView()
                    case .resetView:
                        ResetView()
                    case .subscribeView:
                        SubscribeView {
                            isProUnlocked = true
                            UserDefaults.standard.set(true, forKey: "isProUnlocked")
                        }
                    case .notificationView:
                        NotificationView()
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
    }
}


//#Preview {
//    ContentView()
//}
