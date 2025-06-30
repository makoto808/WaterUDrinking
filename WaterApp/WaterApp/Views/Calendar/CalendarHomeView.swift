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
        ScrollView(.vertical, showsIndicators: true) {
            VStack {                
                CalendarView(isShowingDrinkDetails: $isShowingDrinkDetails)
                
                Spacer(minLength: 20)
            }
            .padding(.horizontal)
            .animation(.easeInOut, value: isShowingDrinkDetails)
        }
        .background(Color.backgroundWhite)
    }
}

#Preview {
    let mockDrinkListVM = DrinkListVM()
    let mockCalendarHomeVM = CalendarHomeVM()
    
    return CalendarHomeView()
        .environment(mockDrinkListVM)
        .environment(mockCalendarHomeVM)
}
