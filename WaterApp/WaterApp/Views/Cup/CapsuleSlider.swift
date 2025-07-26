//
//  CapsuleSlider.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/24/25.
//

import SwiftUI

struct CapsuleSlider: View {
    @Binding var value: Double
    
    let range: ClosedRange<Double>
    let step: Double
    var onValueChanged: ((Double) -> Void)? = nil
    
    private let thumbWidth: CGFloat = 10
    private let thumbHeight: CGFloat = 30
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Track background
                Capsule()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 10)
                
                // Filled progress bar
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [Color.accentColor.opacity(0.8), Color.accentColor],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(
                        width: CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound)) * geometry.size.width,
                        height: 10
                    )
                
                // Thumb bar
                Rectangle()
                    .fill(Color.white)  // always pure white
                    .frame(width: thumbWidth, height: thumbHeight)
                    .cornerRadius(thumbWidth / 2)
                    .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 1)
                    .offset(
                        x: CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound)) * geometry.size.width - thumbWidth / 2
                    )
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        let location = gesture.location.x / geometry.size.width
                        let newValue = Double(location) * (range.upperBound - range.lowerBound) + range.lowerBound
                        let stepped = (newValue / step).rounded() * step
                        value = min(max(stepped, range.lowerBound), range.upperBound)
                        onValueChanged?(value)
                    }
                    .onEnded { _ in
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    }
            )
        }
        .frame(height: 40)
        .padding(.horizontal, 30)
    }
}


//#Preview {
//    @State var previewValue: Double = 10.0
//    
//    return CapsuleSlider(
//        value: $previewValue,
//        range: 0...20,
//        step: 0.1
//    )
//    .frame(height: 60)
//    .padding()
//}
