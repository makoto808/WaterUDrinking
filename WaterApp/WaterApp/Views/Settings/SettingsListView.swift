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
                Section(header: Text("Membership").fontSmallTitle()) {
                    SettingsNavRow(title: " Become A Hydrated Member") {
                        drinkListVM.navPath.append(.purchaseView)
                    }
                }
                .textCase(nil)
                
                Section(header: Text("App Settings").fontSmallTitle()) {
                    SettingsNavRow(title: " Edit Your Goal") {
                        drinkListVM.navPath.append(.dailyWaterGoal)
                    }
                    
                    SettingsNavRow(title: " Reset Today's Total") {
                        drinkListVM.navPath.append(.resetView)
                    }
                    
                    SettingsNavRow(title: " App Appearance") {
                        drinkListVM.navPath.append(.resetView)
                    }
                }
                .textCase(nil)
                
                Section(header: Text("Notifications").fontSmallTitle()) {
                    SettingsNavRow(title: " Push Notifications") {
                        
                    }
                    
                    SettingsNavRow(title: " Set A Reminder") {
                        drinkListVM.navPath.append(.notificationView)
                    }
                }
                .textCase(nil)
                
                
                
                Section(header: Text("Customer Support").fontSmallTitle()) {
                    SettingsNavRow(title: " Help & Support") {
                        
                    }
                    
                    SettingsNavRow(title: " Give Us A Review") {
                        
                    }
                }
                .textCase(nil)
                
                Section(header: Text("Legal").fontSmallTitle()) {
                    SettingsNavRow(title: " Privacy Notice") {
                        
                    }
                    
                    SettingsNavRow(title: " Terms Of Service") {
                        
                    }
                }
                .textCase(nil)
                
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
                ToolbarItem(placement: .principal) {
                    Text("Settings")
                        .fontBarLabel()
                }
            }
        }
    }
}

#Preview {
    SettingsListView()
        .environment(DrinkListVM())
}
