//
//  ResetView.swift
//  WaterApp
//
//  Created by Gregg Abe on 6/15/25.
//

import SwiftUI
//TODO: might be better to have this under the bar chart in calendar view
struct ResetView: View {
    @Environment(DrinkListVM.self) private var vm
    
    @State private var showAlert = false
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
                Button("Reset?") {
                    showAlert = true
                }
                .buttonBorderShape(.capsule)
                .buttonStyle(.borderedProminent)
                .font(.custom("ArialRoundedMTBold", size: 25))
                .textCase(.uppercase)
                .alert("Are You Sure?", isPresented: $showAlert) {
                    Button("Cancel", role: .cancel) {}
                    Button("OK", role: .destructive) {
                        vm.totalOz = 0
//                        vm.navPath.removeLast()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
    }
}

#Preview {
    ResetView()
}


