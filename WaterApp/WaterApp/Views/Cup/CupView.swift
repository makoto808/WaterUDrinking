//
//  CupView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/22/25.
//

import SwiftUI

struct CupView: View {
    @Environment(DrinkListVM.self) private var vm
    
    @State private var waveOffset = Angle(degrees: 0)
    
    @State var ozGoal: Double = 120
    
    var body: some View {
        GeometryReader { wave in
            ZStack {
//                Text("\(self.vm.totalOz)%")
//                    .foregroundColor(.primary)
//                    .font(Font.system(size: 0.25 * min(wave.size.width, wave.size.height) ))
                
                Circle()
                    .stroke(Color.gray, lineWidth: 0.03 * min(wave.size.width, wave.size.height))
                    .overlay(
                        WaveMotion(offset: Angle(degrees: self.waveOffset.degrees), percent: Double(vm.totalOz)/ozGoal)
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

//#Preview {
//    CupView()
//}
