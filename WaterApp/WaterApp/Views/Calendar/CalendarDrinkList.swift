//
//  CalendarDrinkList.swift
//  WaterApp
//
//  Created by Gregg Abe on 6/24/25.
//

import SwiftUI

struct CalendarDrinkList: View {
    @Environment(DrinkListVM.self) private var drinkListVM
    
    let drinks: [CachedDrinkItem]
    
    private var oz: Double {
        drinks.reduce(0) { $0 + $1.volume }
    }
    
    private var percentage: Int {
        guard drinkListVM.totalOzGoal > 0 else { return 0 }
        return Int(min((oz / drinkListVM.totalOzGoal) * 100, 999))
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
                
                ForEach(drinks, id: \.id) { drink in
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
                           // Action here
                       }
                       .button3()
                       Spacer()
                   }
               }
            //            .transition(.move(edge: .bottom).combined(with: .opacity))
            .transition(.opacity)
            .padding(.top)
        }
    }
}

//#Preview {
//    CalendarDrinkList()
//}
