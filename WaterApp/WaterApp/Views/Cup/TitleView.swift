//
//  TitleView.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/15/25.
//

import SwiftUI

struct TitleView: View {
    @Environment(DrinkListVM.self) private var vm
    
    let dayOfWeek = Calendar.current.component(.weekday, from: Date())
    var totalOzGoal: Double = 120.0
    
    var body: some View {
            switch dayOfWeek {
            case 1: titleFont("Sunday Sips")
            case 2: titleFont("Motivational Monday")
            case 3: titleFont("Tonic Tuesday")
            case 4: titleFont("Water Wednesday")
            case 5: titleFont("Thirsty Thursdays")
            case 6: titleFont("Friday Fizz")
            case 7: titleFont("Saturday Sips")
            default: Text("Unknown")
        }

        Spacer()
        
        if vm.totalOz == 0.0 {
            Text("You are dehydrated!")
                .font(.custom("ArialRoundedMTBold", size: 20))
        } else if vm.totalOz >= 120.0 {
            Text("You are fully hydrated!")
                .font(.custom("ArialRoundedMTBold", size: 20))
                .padding(.horizontal, 20)
        } else if vm.totalOz > 0.0 {
            Text("You drank \(vm.totalOz.clean) oz today! \(vm.percentTotal.rounded(.up).clean)% of your goal!")
                .foregroundStyle(.primary)
                .font(.custom("ArialRoundedMTBold", size: 20))
                .lineLimit(1)
                .allowsTightening(true)
                .minimumScaleFactor(0.30)
                .padding(.horizontal, 20)
        }
    }
}

    func titleFont(_ title: String) -> some View {
        Text(title)
            .font(.custom("ArialRoundedMTBold", size: 45))
            .lineLimit(1)
            .allowsTightening(true)
            .minimumScaleFactor(0.30)
            .padding(.horizontal, 20)
    }


    
//
//#Preview {
//    TitleView()
//}
