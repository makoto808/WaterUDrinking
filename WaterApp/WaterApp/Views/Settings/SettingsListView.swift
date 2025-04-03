//
//  SettingsListView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/27/25.
//

import SwiftUI

struct SettingsListView: View {
    let backgroundWhite = Color(red: 0.9373, green: 0.9607, blue: 0.9607)
    
    var body: some View {
        ZStack {
            Color.backgroundWhite.ignoresSafeArea()
            
            
            VStack {
                List {
                    Section {
                        Button("Give us a review") {
                            
                        }
                    }
                    
                    Section {
                        Button("Edit your goal") {
                            
                        }
                        Button("Set a reminder") {
                            
                        }
                    }
                    
                    Section {
                        Button("Cocktail Menu") {
                            
                        }
                        Button("Widgets") {
                            
                        }
                        Button("App Icons") {
                            
                        }
                    }
                    
                    Section {
                        Button("Start time of day") {
                            
                        }
                        Button("Measurements") {
                            
                        }
                        Button("Apple Health Sync") {
                            
                        }
                        Button("Apple WatchOS") {
                            
                        }
                        Button("iCloud Backup") {
                            
                        }
                    }
                    
                    Section {
                        Button("Language") {
                            
                        }
                        Button("Help & Support") {
                            
                        }
                    }
                    
                    Section {
                        Button("Hydrate your friends!") {
                            
                        }
                        .buttonBorderShape(.capsule)
                        .buttonStyle(.borderedProminent)
                    }
                } 
                .listStyle(.automatic)
                
            }
        }
    }
}


#Preview {
    SettingsListView()
}



