//
//  ResetView.swift
//  WaterApp
//
//  Created by Gregg Abe on 6/15/25.
//

import SwiftData
import SwiftUI

struct ResetView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(DrinkListVM.self) private var drinkListVM
    
    @State private var showAlert = false
    @State private var waveOffset = Angle(degrees: 0)
    
    @FocusState private var keyboardFocused: Bool
    
    var body: some View {
        ZStack {
            Color("AppBackgroundColor")
                .ignoresSafeArea()
            
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
                Button("Reset?") {
                    showAlert = true
                }
                .button2()
                .alert("Are You Sure?", isPresented: $showAlert, actions: {
                    Button("Cancel", role: .cancel) {}
                    Button("OK", role: .destructive) {
                        Task {
                            drinkListVM.deleteTodaysItems(modelContext)
                            drinkListVM.refreshFromCache(modelContext)
                            drinkListVM.navPath = []
                        }
                    }
                }, message: {
                    Text("This will reset today's total.")
                })
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
        .backChevronButton(using: drinkListVM)
    }
}

//#Preview {
//    ResetView()
//        .environment(DrinkListVM())
//}
