//
//  SettingsListView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/27/25.
//

import SwiftUI

struct SettingsListView: View {
    @Environment(DrinkListVM.self) private var drinkListVM
    
    var body: some View {
        VStack {
            List {
                Section {
                    Button("Give Us A Review") {
                        //TODO: Link to appstore review
                    }
                }
                
                Section {
                    Button {
                        drinkListVM.navPath.append(.dailyWaterGoal)
                    } label: {
                        Text("Edit Your Goal")
                    }
                    
                    Button {
                        drinkListVM.navPath.append(.resetView)
                    } label: {
                        Text("Reset Today's Total")
                    }
                }
                
                Section {
                    Button {
                        drinkListVM.navPath.append(.subscribeView)
                    } label: {
                        Text("Become A Hydrated Member")
                    }
                }
                
                //TODO: Future Settings Tabs below
            }
            .listStyle(.automatic)
            .scrollContentBackground(.hidden)
            .background(Color.backgroundWhite)
        }
    }
}

#Preview {
    SettingsListView()
        .environment(DrinkListVM())
}
