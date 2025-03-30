//
//  DrinkFillView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/29/25.
//

import SwiftUI

struct CustomOzView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "x.circle")
                .resizable()
                .frame(width: 40, height: 40)
        }
    }
}

struct DrinkFillView: View {
    @State private var showingCustomOzView = false
    @State private var value = 0.0
    
    @State private var settingsDetent = PresentationDetent.medium
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            
            Slider(value: $value, in: 0...16.95, step: 0.1)
//              .rotationEffect(Angle(degrees: 270))
            .padding(30)
            
            ZStack{
                Image("waterBottle")
                    .resizable()
                    .frame(width: 500, height: 500, alignment: .center)
                //TODO: adds another layer for fill effect
            }
            
            Text("\(value.formatted()) oz")
                .font(.custom("ArialRoundedMTBold", size: 45))
            
            Spacer()
            
            HStack {
                Button {
                //TODO: select similar drinks within of different sizes
                } label: {
                    Image("waterBottle")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                
                Spacer()
                
                Button("+ WATER ") {
                //TODO: adds value to cup HomeView
                }
                .buttonBorderShape(.capsule)
                .buttonStyle(.borderedProminent)
                .font(.custom("ArialRoundedMTBold", size: 25))
                
                Spacer()
                
                Button {
                    showingCustomOzView.toggle()
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                .sheet(isPresented: $showingCustomOzView) {
                    CustomOzView()
                        .presentationDetents([.fraction(3/4)], selection: $settingsDetent)
                }
            }
            .padding(25)
            
            Spacer()
        }
    }
}

#Preview {
    DrinkFillView()
}
