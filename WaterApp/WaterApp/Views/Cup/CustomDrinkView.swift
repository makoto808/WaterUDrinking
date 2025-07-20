//
//  CustomDrinkView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/31/25.
//

import SwiftUI

struct CustomDrinkView: View {
    @State private var dailyWaterGoal: String = ""
    @State private var waveOffset = Angle(degrees: 0)
    
    var body: some View {
        ZStack {
            Color("AppBackgroundColor").ignoresSafeArea()
            GeometryReader { geo in
                WaveMotion(offset: waveOffset, percent: 3.9 / 8.0)
                    .fill(Color(red: 0, green: 0.5, blue: 0.75, opacity: 0.5))
                    .frame(width: geo.size.width + 100)
                    .offset(x: -50)
                    .ignoresSafeArea()
                    .onAppear {
                        withAnimation(.linear(duration: 3.5).repeatForever(autoreverses: false)) {
                            waveOffset = Angle(degrees: 360)
                        }
                    }
            }
            VStack {
                Spacer()
                
                Text("💧 More Features Coming Soon!")
                    .fontProTitle()
                
                Spacer()
                Spacer()
            }
        }
    }
}

#Preview {
    CustomDrinkView()
}

//
//    var body: some View {
//        List {
//            Section {
//                HStack {
//                    Image("waterBottle").CDVresize()
//                    
//                    VStack(alignment: .leading, spacing: 5) {
//                        
//                        Text("Organic Water").fontSmallTitle()
//                        
//                        Text("100% Rate of Hydration").fontSmallTitle2()
//                    }
//                }
//            }
//            
//            Section {
//                HStack {
//                    Image("waterBottle").CDVresize()
//                    
//                    VStack(alignment: .leading, spacing: 5) {
//                        
//                        Text("Mineral Water").fontSmallTitle()
//                        
//                        Text("100% Rate of Hydration").fontSmallTitle2()
//                    }
//                }
//            }
//            
//            Section {
//                HStack {
//                    Image("waterBottle").CDVresize()
//                    
//                    VStack(alignment: .leading, spacing: 5) {
//                        
//                        Text("Sparkling Water").fontSmallTitle()
//                        
//                        Text("100% Rate of Hydration").fontSmallTitle2()
//                    }
//                }
//            }
//            
//            Section {
//                HStack {
//                    Image("waterBottle").CDVresize()
//                    
//                    VStack(alignment: .leading, spacing: 5) {
//                        
//                        Text("Coconut Water").fontSmallTitle()
//                        
//                        Text("90% Rate of Hydration").fontSmallTitle2()
//                    }
//                }
//            }
//            
//            Section {
//                HStack {
//                    Image("waterBottle").CDVresize()
//                    
//                    VStack(alignment: .leading, spacing: 5) {
//                        
//                        Text("Electrolyte Water").fontSmallTitle()
//                        
//                        Text("100% Rate of Hydration").fontSmallTitle2()
//                    }
//                }
//            }
//        }
//    }
//}
