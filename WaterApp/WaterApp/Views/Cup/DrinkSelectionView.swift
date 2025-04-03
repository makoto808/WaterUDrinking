//
//  DrinkSelectionView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/23/25.
//

import SwiftUI

struct DrinkSelectionView: View {
    @State private var drinkImage: [String] = ["waterBottle", "tea", "coffee", "soda", "juice", "milk", "energyDrink", "beer"]
    @State private var drinkName: [String] = ["Water", "Tea", "Coffee", "Soda", "Juice", "Milk", "Energy Drink", "Beer"]
    
    @State private var scale = 1.0
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: -20) {
                        ForEach(drinkImage.indices, id: \.self) { drink in
                            VStack(spacing: 10) {
                                NavigationLink(destination: DrinkFillView()) {
                                            Image(drinkImage[drink])
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
    }
}



// add in button after 8th drink for other options of drinks. will not replace anything in first 8

#Preview {
    DrinkSelectionView()
}


//struct BounceButtonStyle: ButtonStyle {
//    public func makeBody(configuration: Self.Configuration) -> some View {
//        configuration.label
//            .scaleEffect(configuration.isPressed ? 3.0 : 1.0)
//    }
//}
