//
//  DrinkFillView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/29/25.
//

import SwiftUI

struct DrinkFillView: View {
    @State private var value = 0.0
    
    var body: some View {
        VStack {
            Slider(
                           value: $value,
                           in: 0...16.95,
                           step: 0.1
                       )
            .padding(30)
                       
            Spacer()
            Spacer()
            
            ZStack{
                Image("waterBottle")
                    .resizable()
                    .frame(width: 500, height: 500, alignment: .center)
                
                Image("waterBottle")
                    .resizable()
                    .frame(width: 500, height: 500, alignment: .center)
            }
            Text("\(value.formatted()) oz")
                .font(.custom("ArialRoundedMTBold", size: 45))
                
            
            
            
            Spacer()
            
            HStack {
                Button {
                    
                } label: {
                    Image("waterBottle")
                        .resizable()
                        .frame(width: 60, height: 60)
                }
                
                Spacer()
                
                Button("+ WATER") {
                    
                }
                .buttonBorderShape(.capsule)
                .buttonStyle(.borderedProminent)
                
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
            }
            .padding(20)
            
            Spacer()
            
        }
    }
}

#Preview {
    DrinkFillView()
}
