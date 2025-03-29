//
//  DrinkSelectionView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/23/25.
//

import SwiftUI

struct DrinkSelectionView: View {
    @State private var image: [String] = ["waterBottle", "tea", "coffee", "soda", "juice", "milk", "energyDrink", "beer"]
    @State private var drinkName: [String] = ["Water", "Tea", "Coffee", "Soda", "Juice", "Milk", "Energy Drink", "Beer"]
    
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: -20) {
                    ForEach(0..<8) { beverage in
                        VStack(spacing: 10) {
                            Button {
                                
                            } label : {
                                Image(image[beverage])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 110)
                            }
                            
                            Text(drinkName[beverage])
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

// need to create array of drink images and titles
// add in button after 8th drink for other options of drinks. will not replace anything in first 8

#Preview {
    DrinkSelectionView()
}

//struct MenuItem: Identifiable {
//    let id = UUID().uuidString
//    let name: String
//    let img: String
