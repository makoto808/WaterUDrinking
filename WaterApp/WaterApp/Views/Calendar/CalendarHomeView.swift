//
//  CalendarHomeView.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/16/25.
//

import SwiftUI

struct CalendarHomeView: View {
    @Environment(CalendarHomeVM.self) private var calendarHomeVM
    @Environment(DrinkListVM.self) private var drinkListVM
    
    @State private var isShowingDrinkDetails = false
    
    var body: some View {
        ZStack {
            Color.backgroundWhite.ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    if !isShowingDrinkDetails {
                        Spacer(minLength: 20)
                        
                        BarChart()
                            .transition(.opacity)
                        
                        Spacer(minLength: 20)
                    } else {
                        Spacer(minLength: -40)
                    }

                    Spacer(minLength: 20)
                    
                    CalendarView(isShowingDrinkDetails: $isShowingDrinkDetails)
                    
                    Spacer(minLength: 20)
                }
                .padding(.horizontal)
                .animation(.easeInOut, value: isShowingDrinkDetails)
            }
        }
    }
}

#Preview {
    let mockDrinkListVM = DrinkListVM()
    let mockCalendarHomeVM = CalendarHomeVM()

    return CalendarHomeView()
        .environment(mockDrinkListVM)
        .environment(mockCalendarHomeVM)
}
