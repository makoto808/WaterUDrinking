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
            
            WaveMotion(offset: Angle(degrees: self.waveOffset.degrees), percent: Double(3.9/8.0))
                .fill(Color(red: 0, green: 0.5, blue: 0.75, opacity: 0.5))
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(Animation.linear(duration: 3.5).repeatForever(autoreverses: false)) {
                        self.waveOffset = Angle(degrees: 360)
                    }
                }
            
            VStack {
                Spacer()
                
                Text("Daily Water Goal")
                    .font(.custom("ArialRoundedMTBold", size: 45))
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .allowsTightening(true)
                    .minimumScaleFactor(0.30)
                    .padding(.horizontal, 5)
                
                HStack(spacing: 2) {
                    TextField("Enter Here", text: self.$dailyWaterGoal.max(3))
                        .font(.custom("ArialRoundedMTBold", size: 35))
                        .foregroundStyle(.primary)
                        .frame(width: 190)
                        .lineLimit(1)
                        .focused($keyboardFocused)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)

                    if !dailyWaterGoal.isEmpty {
                        Text("oz")
                            .font(.custom("ArialRoundedMTBold", size: 35)) // Match font size
                            .foregroundColor(.primary)
                            .alignmentGuide(.firstTextBaseline) { d in d[.firstTextBaseline] }
                    }
                }
                .padding(8)

                
                Spacer()
                Spacer()
                Spacer()
                
                if dailyWaterGoal.isEmpty {
                    
                } else {
                    Button("Right On!") {
                        // Add logic to save to oz goal
                        keyboardFocused = false
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
        .environment(DrinkListVM()) // Inject environment object
}

