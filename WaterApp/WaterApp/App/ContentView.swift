//
//  ContentView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/22/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @State var vm = DrinkListVM()
    
    var body: some View {
        NavigationStack(path: $vm.navPath) {
            HomeView()
                .navigationDestination(for: NavPath.self) { navPath in
                switch navPath {
                case .calendar:
                    CalendarHomeView()
                case .settings:
                    SettingsListView()
                case .drinkFillView(let drink):
                    DrinkFillView(item: drink)
                }
            }
        }
        .environment(vm)
    }
}

#Preview {
    ContentView()
}
