//
//  StarryOverlayView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/24/25.
//

import SwiftUI

struct StarryOverlayView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<100, id: \.self) { _ in
                    Circle()
                        .fill(Color.white.opacity(Double.random(in: 0.2...0.8)))
                        .frame(width: CGFloat.random(in: 1...3), height: CGFloat.random(in: 1...3))
                        .position(
                            x: CGFloat.random(in: 0...geometry.size.width),
                            y: CGFloat.random(in: 0...geometry.size.height)
                        )
                }
            }
        }
        .ignoresSafeArea()
        .blendMode(.screen)
        .allowsHitTesting(false)
    }
}

#Preview {
    StarryOverlayView()
}
