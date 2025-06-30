//
//  CalendarDrinkList.swift
//  WaterApp
//
//  Created by Gregg Abe on 6/24/25.
//

import SwiftUI

struct CalendarDrinkList: View {
    @Environment(CalendarHomeVM.self) private var calendarVM
    @Environment(DrinkListVM.self) private var drinkListVM
    
    @State private var isShowingSheet = false
    
    let drinks: [CachedDrinkItem]
    let selectedDate: Date
    
    private var oz: Double {
        calendarVM.totalOunces(for: selectedDate)
    }
    
    private var percentage: Int {
        calendarVM.percentageOfGoal(for: selectedDate, goal: drinkListVM.totalOzGoal)
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer(minLength: 20)
            
            CupViewOverride(oz: oz, goal: drinkListVM.totalOzGoal)
                .frame(width: 200, height: 200)
            
            Text("\(percentage)% of goal")
                .fontCustomDrinkViewSubtitle()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Total: \(oz, specifier: "%.0f") oz")
                    .fontBarLabel()
                    .padding(.top)
                
                ForEach(drinks.sorted(by: { $0.date > $1.date }), id: \.id) { drink in
                    HStack(spacing: 12) {
                        Image(drink.img)
                            .CDVresize2()
                        
                        VStack(alignment: .leading) {
                            Text(drink.name)
                                .fontCustomDrinkViewSubtitle()
                            Text("\(drink.volume, specifier: "%.0f") oz")
                                .fontCustomDrinkViewTitle()
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 4)
                }
                
                HStack {
                    Spacer()
                    Button("Add / Delete") {
                        isShowingSheet = true
                    }
                    .button1()
                    Spacer()
                }
                .sheet(isPresented: $isShowingSheet) {
                    CalendarListUpdate(
                        calendarVMBindable: calendarVM,
                        selectedDate: selectedDate
                    )
                    .presentationDetents([.medium, .large])
                }
            }
            //            .transition(.move(edge: .bottom).combined(with: .opacity))
            .transition(.opacity)
            .padding(.top)
        }
    }
}


