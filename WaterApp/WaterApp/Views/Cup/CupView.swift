//
//  CupView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/22/25.
//

import SwiftUI

struct CupView: View {
    @Environment(DrinkListVM.self) private var vm
    @Environment(\.modelContext) private var modelContext

    @State private var waveOffset = Angle(degrees: 0)

    var body: some View {
        GeometryReader { wave in
            ZStack {
                Circle()
                    .stroke(Color.gray, lineWidth: 0.03 * min(wave.size.width, wave.size.height))
                    .overlay(
                        WaveMotion(
                            offset: self.waveOffset,
                            percent: vm.totalOzGoal == 0 ? 0 : Double(vm.totalOz) / vm.totalOzGoal
                        )
                        .fill(Color(red: 0, green: 0.5, blue: 0.75, opacity: 0.5))
                        .clipShape(Circle().scale(0.92))
                    )
            }
            .padding(.horizontal)
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                self.waveOffset = Angle(degrees: 360)
            }
        }
    }
}


#Preview {
    let mockVM = DrinkListVM()
    mockVM.totalOz = 60
    mockVM.totalOzGoal = 100
    return CupView()
        .environment(mockVM)
}


