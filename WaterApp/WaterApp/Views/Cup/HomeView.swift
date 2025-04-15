//
//  HomeView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/22/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(DrinkListVM.self) private var vm
    @State private var goToCalendar = false
    @State private var goToSettings = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Spacer()
                
                Text("Thirsty Thursdays")
                    .font(.custom("ArialRoundedMTBold", size: 45))
                    .lineLimit(1)
                    .allowsTightening(true)
                    .minimumScaleFactor(0.30)
                    .padding(.horizontal, 20)
                //Fix later: Create dynamic text scaling to fit width of view
                
                if vm.totalOz == 0.0 {
                    Text("You are dehydrated!")
                        .font(.custom("ArialRoundedMT", size: 20))
                } else if vm.totalOz > 0.0 {
                    HStack {
                        Text("You drank \(vm.totalOz, specifier: "%.1f") oz today!")
                            .font(.custom("ArialRoundedMT", size: 20))
                    } //TODO: if number ends in .0 , hide the .0
                }
                
                Spacer()
                Spacer()
                
                CupView(ozGoal: 120)
                
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
                Button {
                    vm.navPath.append(.calendar)
                } label: {
                    Image(systemName: "calendar")
                }
            } //TODO: transition from left to right,
            //Access water streak / data for previous days
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    vm.navPath.append(.settings)
                } label: {
                    Image(systemName: "gearshape.fill")
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
