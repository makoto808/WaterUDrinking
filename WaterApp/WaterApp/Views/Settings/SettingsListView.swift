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
                
                //TODO: Future Settings Tabs below
                
                //Button("Set a reminder") {
                //
                //                        }
                //                    }
                //
                //                    Section {
                //                        Button("Cocktail Menu") {
                //
                //                        }
                //                        Button("Widgets") {
                //
                //                        }
                //                        Button("App Icons") {
                //
                //                        }
                //                    }
                //
                //                    Section {
                //                        Button("Measurements") {
                //
                //                        }
                //                        Button("Apple Health Sync") {
                //
                //                        }
                //                        Button("Apple WatchOS") {
                //
                //                        }
                //                        Button("iCloud Backup") {
                //
                //                        }
                //                    }
                //
                //                    Section {
                //                        Button("Language") {
                //
                //                        }
                //                        Button("Help & Support") {
                //
                //                        }
                //                        Button("Have an App Idea?") {
                //
                //                        }
                //                    }
                //
                //                    Section {
                //                        Button("Hydrate your friends!") {
                //
                //                        }
                //                        .buttonBorderShape(.capsule)
                //                        .buttonStyle(.borderedProminent)
                //                    }
                
            }
            .listStyle(.automatic)
            .scrollContentBackground(.hidden)
            .background(Color.backgroundWhite)
        }
    }
}

//#Preview {
//    SettingsListView()
//}
