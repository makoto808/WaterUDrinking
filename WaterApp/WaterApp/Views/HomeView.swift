//
//  HomeView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/22/25.
//

import SwiftUI

struct HomeView: View {
    @State private var waterLevelPercent = 35.0
    
    let backgroundBlue = Color(red: 0.9373, green: 0.9607, blue: 0.9607)
    //can this be refactored into a separate file?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(backgroundBlue)
                    .ignoresSafeArea()
                
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
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            //Access water streak / data for previous days
                        } label: {
                            Image(systemName: "calendar")
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
