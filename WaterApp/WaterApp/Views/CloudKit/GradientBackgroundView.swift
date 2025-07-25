//
//  GradientBackgroundView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/24/25.
//

import SwiftUI

struct GradientBackgroundView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var startColor: Color {
        colorScheme == .dark ? Color("GradientStartPM") : Color("GradientStartAM")
    }
    
    var endColor: Color {
        colorScheme == .dark ? Color("GradientEndPM") : Color("GradientEndAM")
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [startColor, endColor],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            if colorScheme == .dark {
                StarryOverlayView()
            }
        }
    }
}

#Preview {
    GradientBackgroundView()
        .preferredColorScheme(.light) // You can change this to .dark to preview
}
