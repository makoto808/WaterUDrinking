//
//  CustomDrinkView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/31/25.
//

import SwiftUI

struct CustomDrinkView: View {
    @State private var drinkImage: [String] = ["waterBottle", "energyDrink"]
    @State private var drinkName: [String] = ["Water", "Energy Drink"]
    
    var body: some View {
        NavigationStack {
            Text("HI")
            HStack(spacing: -20) {
                ForEach(drinkImage.indices, id: \.self) { drink in
                    VStack(spacing: 10) {
                        /*NavigationLink(destination: DrinkFillView())*/
                        Button {
                        }label: { Image(drinkImage[drink])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 110)
                        }
                        
                        Text(drinkName[drink])
                            .foregroundStyle(.gray)
                            .font(.custom("ArialRoundedMTBold", size: 16))
                    }
                }
                .scrollTransition { content, phase in
                    content
                        .opacity(phase.isIdentity ? 1.0 : 0.0)
                        .offset(y: phase.isIdentity ? 0 : 50)
                }
            }
        }
    }
}



#Preview {
    CustomDrinkView()
}

