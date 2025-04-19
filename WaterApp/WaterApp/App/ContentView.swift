//
//  ContentView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/22/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var vm = DrinkListVM()
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
        NavigationStack(path: $vm.navPath) {
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
                }
            }
        }
        .environment(vm)
        .onAppear {
            vm.setModelContext(modelContainer.mainContext)
            calendarHomeVM.setModelContext(modelContainer.mainContext)
        }
    }
}

#Preview {
    ContentView()
}
