//
//  GoalView.swift
//  WaterApp
//
//  Created by Gregg Abe on 6/11/25.
//

import SwiftUI

struct GoalView: View {
    @Environment(DrinkListVM.self) private var drinkListVM
    @Environment(\.modelContext) private var modelContext
    
    @State private var dailyWaterGoal: String = ""
    @State private var waveOffset = Angle(degrees: 0)
    
    @FocusState private var keyboardFocused: Bool
    
    var body: some View {
        ZStack {
            Color("AppBackgroundColor").ignoresSafeArea()
            GeometryReader { geo in
                WaveMotion(offset: waveOffset, percent: 3.9 / 8.0)
                    .fill(Color(red: 0, green: 0.5, blue: 0.75, opacity: 0.5))
                    .frame(width: geo.size.width + 100)
                    .offset(x: -50)
                    .ignoresSafeArea()
                    .onAppear {
                        withAnimation(.linear(duration: 3.5).repeatForever(autoreverses: false)) {
                            waveOffset = Angle(degrees: 360)
                        }
                    }
            }
            
            VStack {
                Spacer()
                
                Text("Daily Water Goal")
                    .fontTitle()
                
                HStack(spacing: -2) {
                    TextField("Enter Here", text: self.$dailyWaterGoal.max(3))
                        .fontGoalViewTextField()
                        .keyboardType(.numberPad)
                        .focused($keyboardFocused)
                        .frame(width: 80)
                    
                    if !dailyWaterGoal.isEmpty {
                        Text("oz")
                            .fontOzLabel()
                    }
                }
                .padding(8)
                
                Spacer()
                Spacer()
                Spacer()
                
                if !dailyWaterGoal.isEmpty {
                    Button("Right On!") {
                        keyboardFocused = false
                        if let goal = Double(dailyWaterGoal) {
                            drinkListVM.setGoalAndDismiss(goal, context: modelContext)
                        }
                    }
                    .button2()
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    drinkListVM.navPath.removeLast()
                } label: {
                    Image(systemName: "chevron.backward")
                        .backButton1()
                }
            }
        }
    }
}

#Preview {
    GoalView()
        .environment(DrinkListVM())
}
