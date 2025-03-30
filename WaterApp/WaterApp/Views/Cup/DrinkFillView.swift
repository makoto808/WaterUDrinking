//
//  DrinkFillView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/29/25.
//

import SwiftUI

struct DrinkFillView: View {
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            
            Image("waterBottle")
                .resizable()
                .frame(width: 500, height: 500, alignment: .center)
            
            Text("16.9 oz")
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
