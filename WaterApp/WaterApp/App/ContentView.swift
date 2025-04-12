//
//  ContentView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/22/25.
//

import SwiftUI

struct ContentView: View {
    @State var vm = DrinkListVM()
    
    var body: some View {
        NavigationStack(path: $vm.navPath) {
            HomeView()
                .navigationDestination(for: NavPath.self)
            { navPath in
                switch navPath {
                case .calendar:
                    CalendarView()
                case .settings:
                    SettingsListView()
                case .drinkFillView:
                    Text("")
                }
            }
        }
        .environment(vm)
    }
}

#Preview {
    ContentView()
}
