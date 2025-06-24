//
//  CupViewOverride.swift
//  WaterApp
//
//  Created by Gregg Abe on 6/23/25.
//

import SwiftUI

struct CupViewOverride: View {
    var oz: Double
    var goal: Double

    @State private var waveOffset = Angle(degrees: 0)

    var body: some View {
        GeometryReader { wave in
            ZStack {
                Circle()
                    .stroke(Color.gray, lineWidth: 0.03 * min(wave.size.width, wave.size.height))
                    .overlay(
                        WaveMotion(
                            offset: waveOffset,
                            percent: goal == 0 ? 0 : oz / goal
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
                waveOffset = Angle(degrees: 360)
            }
        }
    }
}

struct CupGoalSummaryView: View {
    let oz: Double
    let goal: Double

    private var percentage: Int {
        guard goal > 0 else { return 0 }
        return Int(min((oz / goal) * 100, 999))
    }

    var body: some View {
        VStack(spacing: 8) {
            CupViewOverride(oz: oz, goal: goal)
                .frame(width: 200, height: 200)

            Text("\(percentage)% of goal")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

//#Preview {
//    CupViewOverride()
//}
