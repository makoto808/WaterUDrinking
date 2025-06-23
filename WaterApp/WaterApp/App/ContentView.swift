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

    @State private var drinkListVM = DrinkListVM()
    @State private var calendarHomeVM = CalendarHomeVM()

    var body: some View {
        NavigationStack(path: $drinkListVM.navPath) {
            HomeView()
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
                }
            }
        }
        .environment(drinkListVM)
        .onAppear {
            drinkListVM.loadFromCache(modelContext)
            drinkListVM.loadUserGoal(context: modelContext)
//            calendarHomeVM.setModelContext(modelContainer.mainContext)
        }
    }
}

#Preview {
    ContentView()
}
