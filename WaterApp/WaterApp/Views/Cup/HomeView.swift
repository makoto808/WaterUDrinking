//
//  HomeView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/22/25.
//

import SwiftUI

struct HomeView: View {
    @State private var waterLevelPercent = 35.0
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    Spacer()
                    
                    Text("Title Water Text")
                        .font(.custom("ArialRoundedMTBold", size: 45))
                    //Fix later: Create dynamic text scaling to fit width of view
                    //can be refactored?
                    
                    Text("Oz of water drank  ||  X% of goal")
                        .font(.custom("ArialRoundedMT", size: 20))
                    
                    Spacer()
                    Spacer()
                    
                    CupView(percent: Int(self.waterLevelPercent))
                    
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
                            Image(systemName: "calendar") //Access water streak / data for previous days
                                
                        }
                    }
                    
                    
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            //Access settings page
                        } label: {
                            Image(systemName: "gearshape.fill")
                        }
                    }
                }
            }
        .navigationBarBackButtonHidden(true)
        }
    }


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CupView(percent: 58)
//    }
//}

#Preview {
    HomeView()
}
