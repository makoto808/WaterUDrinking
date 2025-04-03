//
//  HomeView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/22/25.
//

import SwiftUI

struct HomeView: View {
    @State private var goToCalendar = false
    @State private var goToSettings = false
    
    @State private var waterTotalOz: Double = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()
                    Spacer()
                    
                    Text("Title Water Text")
                        .font(.custom("ArialRoundedMTBold", size: 45))
                    //Fix later: Create dynamic text scaling to fit width of view
                    
                    if waterTotalOz == 0 {
                        Text("You are dehydrated!")
                            .font(.custom("ArialRoundedMT", size: 20))
                    } else if waterTotalOz > 0 {
                        Text("You drank \(waterTotalOz, specifier: "%.1f") oz of water!")
                            .font(.custom("ArialRoundedMT", size: 20))
                    }
                   
                    Spacer()
                    Spacer()
                    
                    CupView()/*percent: Int(self.waterLevelPercent))*/
                    
                    Spacer()
                    Spacer()
                    
                    DrinkSelectionView()
                    
                    Spacer()
                    Spacer()
                }
            }
            .background(Color.backgroundWhite)
            
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink(destination: CalendarView()) {
                        Image(systemName: "calendar")
                    } //TODO: transition from left to right,
                    //Access water streak / data for previous days
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: SettingsListView()) {
                        Image(systemName: "gearshape.fill")
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView()
}

// TODO: NOTES TO DO:
// Lock portrait mode throughout entire app
// Dynamically change title text based off day of week i.e. (Thirsty Thursdays)


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CupView(percent: 58)
//    }
//}
