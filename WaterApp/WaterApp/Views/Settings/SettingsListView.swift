//
//  SettingsListView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/27/25.
//

import SwiftUI

struct SettingsListView: View {
    @Environment(DrinkListVM.self) private var vm
    
    var body: some View {
        VStack {
            List {
                Section {
                    Button("Give us a review") {
                        //TODO: Link to appstore review
                    }
                }
                
                Section {
                    Button {
                        vm.navPath.append(.dailyWaterGoal)
                    } label: {
                        Text("Edit Your Goal")
                    }
                    
                    Button {
                        vm.navPath.append(.reset)
                    } label: {
                        Text("Reset Daily Total")
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
            .listStyle(.automatic) //Lets swift choose appropriate list view based on device
            .scrollContentBackground(.hidden)
            .background(Color.backgroundWhite)
        }
    }
}


#Preview {
    SettingsListView()
}



