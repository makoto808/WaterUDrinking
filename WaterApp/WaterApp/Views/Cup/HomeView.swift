//
//  HomeView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/22/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(DrinkListVM.self) private var vm
    @Environment(\.modelContext) private var modelContext

    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Spacer()
                
                TitleView()
                
                Spacer()
                Spacer()
                
                CupView()
                
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
            }
            
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

//#Preview {
//    let mockVM = DrinkListVM()
//    mockVM.totalOz = 60
//    mockVM.totalOzGoal = 100
//    
//    return HomeView()
//        .environment(mockVM)
//}


// TODO: NOTES TO DO:
// Lock portrait mode throughout entire app
// Transition HomeView from left to right to access CalendarView
// Dynamically change title text based off day of week i.e. (Thirsty Thursdays)
