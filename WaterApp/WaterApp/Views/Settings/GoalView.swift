//
//  GoalView.swift
//  WaterApp
//
//  Created by Gregg Abe on 6/11/25.
//

import SwiftUI

struct GoalView: View {
    @Environment(DrinkListVM.self) private var vm
    
    @State private var dailyWaterGoal: String = ""
    @State private var waveOffset = Angle(degrees: 0)
    
    @FocusState private var keyboardFocused: Bool
    
    var body: some View {
        ZStack {
            Color.backgroundWhite
                .ignoresSafeArea()
            
            WaveMotion(offset: Angle(degrees: self.waveOffset.degrees), percent: Double(3.0/8.0))
                .fill(Color(red: 0, green: 0.5, blue: 0.75, opacity: 0.5))
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                        self.waveOffset = Angle(degrees: 360)
                    }
                }
            
            VStack {
                Spacer()
                
                Text("What is your daily water oz goal?")
                    .font(.custom("ArialRoundedMTBold", size: 45))
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .allowsTightening(true)
                    .minimumScaleFactor(0.30)
                    .padding(.horizontal, 5)
                
                TextField("Enter Here", text: self.$dailyWaterGoal)
                    .font(.custom("ArialRoundedMTBold", size: 35))
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .focused($keyboardFocused)
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center) // Text aligns center
                    .frame(width: 300) // Control width to allow centering
                
                Spacer()
                
                if dailyWaterGoal.isEmpty {
                    
                } else {
                    Button("Right On!") {
                        // Add logic to save to oz goal
                    }
                    .buttonBorderShape(.capsule)
                    .buttonStyle(.borderedProminent)
                    .font(.custom("ArialRoundedMTBold", size: 25))
                    .textCase(.uppercase)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
    }
}

#Preview {
    GoalView()
}
