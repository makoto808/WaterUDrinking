//
//  CloudMotionView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/23/25.
//

import SwiftUI

struct CloudMotionView: View {
    @State private var cloudOffsets: [CGFloat] = Array(repeating: UIScreen.main.bounds.width, count: 5)
    @State private var cloudOpacities: [Double] = Array(repeating: 0.0, count: 5)
    
    private let cloudSpeeds: [Double] = [30, 40, 50, 60, 45] // seconds for full cross
    private let cloudSizes: [CGFloat] = [200, 150, 180, 130, 220]
    private let cloudYOffsets: [CGFloat] = [50, 120, 90, 160, 70]
    private let baseOpacity: [Double] = [0.3, 0.2, 0.25, 0.15, 0.22]
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(0..<5, id: \.self) { i in
                    Image(systemName: "cloud.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: cloudSizes[i])
                        .foregroundColor(.white.opacity(cloudOpacities[i]))
                        .offset(x: cloudOffsets[i], y: cloudYOffsets[i])
                        .onAppear {
                            let distance = geo.size.width + cloudSizes[i]
                            cloudOffsets[i] = distance
                            cloudOpacities[i] = baseOpacity[i]
                            
                            withAnimation(.linear(duration: cloudSpeeds[i]).repeatForever(autoreverses: false)) {
                                cloudOffsets[i] = -cloudSizes[i]
                            }
                            
                            withAnimation(
                                .easeInOut(duration: 6)
                                    .delay(Double(i) * 2)
                                    .repeatForever(autoreverses: true)
                            ) {
                                cloudOpacities[i] = baseOpacity[i] * 0.6
                            }
                        }
                }
            }
            .ignoresSafeArea()
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
