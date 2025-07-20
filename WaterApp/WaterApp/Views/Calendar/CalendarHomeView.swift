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
    
    let purchaseManager: PurchaseManager

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                CalendarView(
                    isShowingDrinkDetails: $isShowingDrinkDetails,
                    purchaseManager: purchaseManager
                )

                Spacer(minLength: 20)
            }
            .padding(.horizontal)
            .animation(.easeInOut, value: isShowingDrinkDetails)
        }
        .background(Color("AppBackgroundColor"))
        .navigationBarBackButtonHidden(true)
        .backChevronButton(using: drinkListVM)
    }
}

#Preview {
    let mockDrinkListVM = DrinkListVM()
    let mockCalendarHomeVM = CalendarHomeVM()
    let mockPurchaseManager = PurchaseManager.shared

    return NavigationStack {
        CalendarHomeView(purchaseManager: mockPurchaseManager)
            .environment(mockDrinkListVM)
            .environment(mockCalendarHomeVM)
    }
}
