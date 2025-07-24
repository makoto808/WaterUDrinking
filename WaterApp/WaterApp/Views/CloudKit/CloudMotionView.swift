//
//  CloudMotionView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/23/25.
//

import SwiftUI

struct CloudMotionView: View {
    private let cloudSpeeds: [Double] = [30, 40, 50, 60, 45]
    private let cloudSizes: [CGFloat] = [200, 150, 180, 130, 220]
    private let cloudYOffsets: [CGFloat] = [50, 120, 90, 160, 70]
    private let baseOpacity: [Double] = [0.3, 0.2, 0.25, 0.15, 0.22]

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(0..<5, id: \.self) { i in
                    let size = cloudSizes[i]
                    let yOffset = cloudYOffsets[i]
                    let speed = cloudSpeeds[i]
                    let initialX = geo.size.width + CGFloat(i) * 100

                    CloudView(
                        size: size,
                        yOffset: yOffset,
                        baseOpacity: baseOpacity[i],
                        duration: speed,
                        initialX: initialX,
                        cloudIndex: i
                    )
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct CloudView: View {
    let size: CGFloat
    let yOffset: CGFloat
    let baseOpacity: Double
    let duration: Double
    let initialX: CGFloat
    let cloudIndex: Int

    @State private var xPosition: CGFloat = .zero

    var body: some View {
        Image(systemName: "cloud.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size)
            .foregroundColor(.white.opacity(baseOpacity))  // fixed opacity here
            .offset(x: xPosition, y: yOffset)
            .onAppear {
                xPosition = initialX
                animateCloud()
            }
    }

    private func animateCloud() {
        let endX = -size

        withAnimation(.linear(duration: duration)) {
            xPosition = endX
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            xPosition = initialX
            animateCloud()
        }
    }
}

#Preview {
    ZStack {
        LinearGradient(colors: [.blue.opacity(0.5), .blue], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
        CloudMotionView()
    }
}
