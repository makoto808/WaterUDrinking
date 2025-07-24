//
//  TitleView.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/15/25.
//

import SwiftUI

struct TitleView: View {
    @Environment(DrinkListVM.self) private var drinkListVM
    
    private let dayOfWeek = Calendar.current.component(.weekday, from: Date())
    
    var totalOzGoal: Double = 120.0
    
    var body: some View {
            switch dayOfWeek {
            case 1: Text("Sunday Sips").fontTitle()
            case 2: Text("Motivational Monday").fontTitle()
            case 3: Text("Tonic Tuesday").fontTitle()
            case 4: Text("Water Wednesday").fontTitle()
            case 5: Text("Thirsty Thursdays").fontTitle()
            case 6: Text("Friday Fizz").fontTitle()
            case 7: Text("Saturday Sips").fontTitle()
            default: Text("Unknown").fontTitle()
        }

        Spacer()
        
        if drinkListVM.totalOz == 0.0 {
            Text("You are dehydrated!")
                .fontSubtitle()
        } else if drinkListVM.totalOz >= drinkListVM.totalOzGoal {
            Text("You are fully hydrated!")
                .fontSubtitle()
            Text("You drank \(drinkListVM.totalOz.formatted()) oz today!")
                .fontSubtitle()
        } else {
            Text("You drank \(drinkListVM.totalOz.formatted()) oz today! \(drinkListVM.percentTotal.rounded(.up).clean)% of your goal!")
                .fontSubtitle()
        }
    }
}

//
//#Preview {
//    TitleView()
//}
