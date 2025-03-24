//
//  DrinkSelectionView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/23/25.
//

import SwiftUI

struct DrinkSelectionView: View {
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
                            Text("Water Bottle")
                                .foregroundStyle(.gray)
                                .font(.custom("ArialRoundedMT", size: 16))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    DrinkSelectionView()
}
