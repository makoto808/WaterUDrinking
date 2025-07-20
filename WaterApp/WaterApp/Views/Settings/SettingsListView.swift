//
//  SettingsListView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/27/25.
//

import SwiftUI

struct SettingsListView: View {
    @Environment(DrinkListVM.self) private var drinkListVM
    
    let appStoreReviewURL = URL(string: "https://apps.apple.com/app/id6748337137?action=write-review")!
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Membership").fontSmallTitle()) {
                    SettingsNavRow(title: " Become A Hydrated Member") {
                        drinkListVM.navPath.append(.purchaseView)
                    }
                    
                    SettingsNavRow(title: " Give Us A Review") {
                        UIApplication.shared.open(appStoreReviewURL)
                        }
                }
                .textCase(nil)
                
                Section(header: Text("App Settings").fontSmallTitle()) {
                    SettingsNavRow(title: " Set A Reminder") {
                        drinkListVM.navPath.append(.notificationView)
                    }
                    
                    SettingsNavRow(title: " Edit Your Goal") {
                        drinkListVM.navPath.append(.dailyWaterGoal)
                    }
                    
                    SettingsNavRow(title: " Reset Today's Total") {
                        drinkListVM.navPath.append(.resetView)
                    }
                    
                    SettingsNavRow(title: " App Appearance") {
                        
                    }
                }
                .textCase(nil)
                
//                Section(header: Text("Notifications").fontSmallTitle()) {
//                    SettingsNavRow(title: " Push Notifications") {
//                        
//                    }
//                    
//                    SettingsNavRow(title: " Set A Reminder") {
//                        drinkListVM.navPath.append(.notificationView)
//                    }
//                }
//                .textCase(nil)
                
//                Section(header: Text("Customer Support").fontSmallTitle()) {
//                    SettingsNavRow(title: " Give Us A Review") {
//                        UIApplication.shared.open(appStoreReviewURL)
//                        }

//                    SettingsNavRow(title: " Help & Support") {
//                        
//                    }
//                }
//                .textCase(nil)
                
                Section(header: Text("Legal").fontSmallTitle()) {
                    SettingsNavRow(title: " Privacy Notice") {
                        if let url = URL(string: "https://makoto808.github.io/waterudrinking-support/privacy") {
                            UIApplication.shared.open(url)
                        }
                    }
                    
                    SettingsNavRow(title: " Terms Of Service") {
                        if let url = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/") {
                            UIApplication.shared.open(url)
                        }
                    }
                }
                .textCase(nil)
            }
            .listStyle(.automatic)
            .scrollContentBackground(.hidden)
            .background(Color("AppBackgroundColor"))
            .navigationBarBackButtonHidden(true)
            .backChevronButton(using: drinkListVM)
            .toolbar {
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
