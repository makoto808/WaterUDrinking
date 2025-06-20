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
            
            VStack {
                Spacer()
                
                BarChart()
                
                Spacer()
                
                CalendarView()
                
                Spacer()
            }
            .padding(.horizontal)
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
