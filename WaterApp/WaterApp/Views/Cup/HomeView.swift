//
//  HomeView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/22/25.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(DrinkListVM.self) private var drinkListVM
    
    var body: some View {
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
        .background(Color.backgroundWhite)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    drinkListVM.navPath.append(.calendar)
                } label: {
                    Image(systemName: "calendar")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    drinkListVM.navPath.append(.settings)
                } label: {
                    Image(systemName: "gearshape.fill")
                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let mockVM = DrinkListVM()
    mockVM.totalOz = 60
    mockVM.totalOzGoal = 100
    
    return HomeView()
        .environment(mockVM)
}

// TODO: Transition HomeView from left to right to access CalendarView

