//
//  GoalView.swift
//  WaterApp
//
//  Created by Gregg Abe on 6/11/25.
//

import SwiftUI

struct GoalView: View {
    @State private var dailyWaterGoal: String = ""
    
    @FocusState private var keyboardFocused: Bool
    
    var body: some View {
        ZStack {
            Color.backgroundWhite
                .ignoresSafeArea()
            
            VStack {
                Text("What is your daily water goal?")
                    .font(.custom("ArialRoundedMTBold", size: 45))
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .allowsTightening(true)
                    .minimumScaleFactor(0.30)
                    .padding(.horizontal, 20)
                
                TextField("Enter Here", text: self.$dailyWaterGoal)
                    .font(.custom("ArialRoundedMTBold", size: 40))
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .focused($keyboardFocused)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center) // Text aligns center
                    .frame(width: 300) // Control width to allow centering
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
    }
}

#Preview {
    GoalView()
}
