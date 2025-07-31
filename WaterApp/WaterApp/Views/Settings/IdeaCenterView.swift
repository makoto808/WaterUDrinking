//
//  IdeaCenterView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/21/25.
//

import SwiftUI

struct IdeaCenterView: View {
    @Environment(DrinkListVM.self) private var drinkListVM
    
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
                
                Text("Tap Here to Email Us Your Ideas!")
                    .fontProTitle()
                    .padding(.bottom, 20)
                
                Button(action: {
                    sendEmail()
                }) {
                    Text("💌")
                        .font(.title)
                }
                
                Spacer()
                Spacer()
            }
        }
        .backChevronButton(using: drinkListVM)
    }
    
    func sendEmail() {
        let email = "waterudrinkingapp@gmail.com"
        let subject = "Idea for WaterUDrinking?"
        let body = "Hi,\nI’d like to share an idea..."
        
        // Prepare the URL string with proper encoding
        let urlString = "mailto:\(email)?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}

//#Preview {
//    IdeaCenterView()
//        .environment(DrinkListVM())
//}
