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
                        drinkListVM.navPath.append(.notificationView)
                    } label: {
                        Text("Set A Reminder")
                    }
                }
                
                Section {
                    Button {
                        drinkListVM.navPath.append(.purchaseView)
                    } label: {
                        Text("Become A Hydrated Member")
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
