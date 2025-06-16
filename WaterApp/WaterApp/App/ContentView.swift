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
    
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: CachedDrinkItem.self)
        } catch {
            fatalError("Failed to create ModelContainer")
        }
    }
    
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
                }
            }
        }
        .environment(drinkListVM)
        .onAppear {
            drinkListVM.setModelContext(modelContext)
            drinkListVM.loadFromCache()
            calendarHomeVM.setModelContext(modelContainer.mainContext)
        }
    }
}

#Preview {
    ContentView()
}
//test
