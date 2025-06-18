//
//  CalendarHomeView.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/16/25.
//

import SwiftUI

struct CalendarHomeView: View { //TODO: Access water streak (Apple Fitness rings style)
    @Environment(CalendarHomeVM.self) private var calendarHomeVM
    
    @Environment(DrinkListVM.self) private var vm
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            Color.backgroundWhite.ignoresSafeArea()
            
            VStack {
                Spacer()
                
                BarChart()
                
                Spacer()

//                better to implemet reset button here instead?
                Button("Reset?") {
                    showAlert = true
                }
                .button2()
                .alert("Are You Sure?", isPresented: $showAlert) {
                    Button("Cancel", role: .cancel) {}
                    Button("OK", role: .destructive) {
                        vm.items = vm.items.map { item in
                            var newItem = item
                            newItem.volume = 0.0
                            return newItem
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()

                
                Spacer()
//                CalendarView()
            }
            .padding(.horizontal)
        }
    }
}

//#Preview {
//    let mockDrinkListVM = DrinkListVM()
//    let mockCalendarHomeVM = CalendarHomeVM()
//
//    return CalendarHomeView()
//        .environment(mockDrinkListVM)
//        .environment(mockCalendarHomeVM)
//}
