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
            case 1: Text("Sunday Sips").titleFont()
            case 2: Text("Motivational Monday").titleFont()
            case 3: Text("Tonic Tuesday").titleFont()
            case 4: Text("Water Wednesday").titleFont()
            case 5: Text("Thirsty Thursdays").titleFont()
            case 6: Text("Friday Fizz").titleFont()
            case 7: Text("Saturday Sips").titleFont()
            default: Text("Unknown").titleFont()
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
            Text("You drank \(vm.totalOz.formatted(FloatingPointFormatStyle())) oz today! \(vm.percentTotal.rounded(.up).clean)% of your goal!")
                .foregroundStyle(.primary)
                .font(.custom("ArialRoundedMTBold", size: 20))
                .lineLimit(1)
                .allowsTightening(true)
                .minimumScaleFactor(0.30)
                .padding(.horizontal, 20)
        }
    }
}

//
//#Preview {
//    TitleView()
//}
