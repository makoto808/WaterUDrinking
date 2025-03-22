//
//  CupView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/22/25.
//

import SwiftUI

struct CupView: View {
    @State private var waveOffset = Angle(degrees: 0)
    
    let percent: Int
    
    var body: some View {
        GeometryReader { wave in
            
            ZStack {
                Text("\(self.percent)%")
                    .foregroundColor(.primary)
                    .font(Font.system(size: 0.25 * min(wave.size.width, wave.size.height) ))
                
                Circle()
                    .stroke(Color.blue, lineWidth: 0.03 * min(wave.size.width, wave.size.height))
                    .overlay(
                        WaveMotion(offset: Angle(degrees: self.waveOffset.degrees), percent: Double(percent)/100)
                            .fill(Color(red: 0, green: 0.5, blue: 0.75, opacity: 0.5))
                            .clipShape(Circle().scale(0.92)))
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
    CupView(percent: 35)
}
