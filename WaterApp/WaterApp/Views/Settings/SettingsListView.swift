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
                    SettingsNavRow(title: "Give Us A Review") {
                        //TODO: Link to appstore review
                    }
                }
                
                Section {
                    SettingsNavRow(title: "Edit Your Goal") {
                        drinkListVM.navPath.append(.dailyWaterGoal)
                    }

                    SettingsNavRow(title: "Reset Today's Total") {
                        drinkListVM.navPath.append(.resetView)
                    }
                }
                
                Section {
                    SettingsNavRow(title: "Set A Reminder") {
                        drinkListVM.navPath.append(.notificationView)
                    }
                }
                
                Section {
                    SettingsNavRow(title: "Become A Hydrated Member") {
                        drinkListVM.navPath.append(.purchaseView)
                    }
                }
                
                //TODO: Future Settings Tabs below
            }
            .listStyle(.automatic)
            .scrollContentBackground(.hidden)
            .background(Color("AppBackgroundColor"))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        drinkListVM.navPath.removeLast()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .backButton1()
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsListView()
        .environment(DrinkListVM())
}
