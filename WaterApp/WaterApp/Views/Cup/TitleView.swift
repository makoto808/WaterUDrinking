//
//  TitleView.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/15/25.
//

import SwiftUI

struct TitleView: View {
    @Environment(DrinkListVM.self) private var drinkListVM
    
    private let calendar = Calendar.current
    private let today = Date()
    private let userDefaultsKey = "dailyTitle"
    
    private var todaysTitle: String {
        let day = calendar.component(.weekday, from: today)
        let dayKey = calendar.startOfDay(for: today).description  // ensures 1 key per day
        
        // Check if today's title is already stored
        if let stored = UserDefaults.standard.dictionary(forKey: userDefaultsKey) as? [String: String],
           let title = stored[dayKey] {
            return title
        }
        
        // Otherwise, pick a new title
        let titlesForDay: [String]
        switch day {
        case 1: titlesForDay = ["Sunday Sips", "Soothing Sunday", "Slow Sip Sunday","Sip & Chill Sunday", "Self-Care Sunday", "Sippin’ Saturday"]
        case 2: titlesForDay = ["Motivational Monday", "Mindful Monday", "Momentum Monday"]
        case 3: titlesForDay = ["Tonic Tuesday", "Tipsy Tuesday", "Take-A-Sip Tuesday"]
        case 4: titlesForDay = ["Water Wednesday", "Wellness Wednesday"]
        case 5: titlesForDay = ["Thirsty Thursday", "Tumbler Thursday"]
        case 6: titlesForDay = ["Friday Fizz", "Fuel-Up Friday", "Fluid Friday", "Fillin’ Fine Friday"]
        case 7: titlesForDay = ["Saturday Sips", "Sippin’ Saturday", "Sip Happens Saturday"]
        default: titlesForDay = ["Stay Hydrated"]
        }
        
        let selected = titlesForDay.randomElement() ?? "Stay Hydrated"
        
        // Save the selected title
        var newStorage = (UserDefaults.standard.dictionary(forKey: userDefaultsKey) as? [String: String]) ?? [:]
        newStorage[dayKey] = selected
        UserDefaults.standard.set(newStorage, forKey: userDefaultsKey)
        
        return selected
    }
    
    var body: some View {
        VStack {
            Text(todaysTitle)
                .fontTitle()
                .padding(.bottom, 5)
            
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
}


#Preview {
    TitleView()
}
