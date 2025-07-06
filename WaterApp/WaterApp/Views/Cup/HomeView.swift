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
                    Image("calendarIcon")
                        .customOzButton()
                        .padding(.horizontal, 8)
                        .padding(.top, 20)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    drinkListVM.navPath.append(.settings)
                } label: {
                    Image("gearIcon")
                        .customDrinkButton()
                        .padding(.horizontal, 6)
                        .padding(.top, 20)
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

    return NavigationStack {
        HomeView()
            .environment(mockVM)
    }
    .modelContainer(for: [UserGoal.self]) // Replace with your actual SwiftData model(s)
}

// TODO: Transition HomeView from left to right to access CalendarView

