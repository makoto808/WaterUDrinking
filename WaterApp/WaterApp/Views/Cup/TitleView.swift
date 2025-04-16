//
//  TitleView.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/15/25.
//

import SwiftUI

struct TitleView: View {
    @Environment(DrinkListVM.self) private var vm
    
    var body: some View {
        Text("Thirsty Thursdays")
            .font(.custom("ArialRoundedMTBold", size: 45))
            .lineLimit(1)
            .allowsTightening(true)
            .minimumScaleFactor(0.30)
            .padding(.horizontal, 20)
        
        Spacer()
        
        if vm.totalOz == 0.0 {
            Text("You are dehydrated!")
                .font(.custom("ArialRoundedMT", size: 20))
        } else if vm.totalOz >= 120.0 {
            Text("You are fully hydrated!")
                .font(.custom("ArialRoundedMT", size: 20))
                .padding(.horizontal, 20)
        } else if vm.totalOz > 0.0 {
            Text("You drank \(vm.totalOz, specifier: "%.1f") oz today!    XX% of your goal!")
                .font(.custom("ArialRoundedMT", size: 20))
                .lineLimit(1)
                .allowsTightening(true)
                .minimumScaleFactor(0.30)
                .padding(.horizontal, 20)
            //TODO: if number ends in .0 , hide the .0
        }
    }
}

#Preview {
    TitleView()
}
