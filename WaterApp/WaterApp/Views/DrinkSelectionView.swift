//
//  DrinkSelectionView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/23/25.
//

import SwiftUI

struct DrinkSelectionView: View {
//    @State var beverageName: [String] = ["Water", "Tea", "Coffee", "Soda", "Juice", "Milk", "Energy Drink", "Beer"]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack(spacing: -40) {
                    ForEach(0..<8) { _ in
                        VStack(spacing: -15) {
                            Image("waterBottle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                            Text("Water")
                                .foregroundStyle(.gray)
                                .font(.custom("ArialRoundedMT", size: 16))
                        }
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
