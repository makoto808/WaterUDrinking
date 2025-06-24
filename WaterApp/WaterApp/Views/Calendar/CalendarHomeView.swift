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
    
    var body: some View {
        ZStack {
            Color.backgroundWhite.ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    Spacer(minLength: 20)  // Optional small spacing
                    
                    BarChart()
                    
                    Spacer(minLength: 20)
                    
                    CalendarView()
                    
                    Spacer(minLength: 20)
                }
                .padding(.horizontal)
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
