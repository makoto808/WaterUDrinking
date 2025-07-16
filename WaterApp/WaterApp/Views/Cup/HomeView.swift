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
        VStack(spacing: 0) {
            Spacer(minLength: 30)
            
            TitleView()
            
            Spacer(minLength: 40)
            
            CupView()
            
            Spacer(minLength: 20)
            
            DrinkSelectionView(isFromHome: true)
            
            Spacer(minLength: 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("AppBackgroundColor"))
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    drinkListVM.navPath.append(.calendar)
                } label: {
                    Image("calendarIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28, height: 28)
                        .padding(.horizontal, 6)
                        .padding(.top, 6)
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    drinkListVM.navPath.append(.settings)
                } label: {
                    Image("gearIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .padding(.horizontal, 6)
                        .padding(.top, 6)
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

