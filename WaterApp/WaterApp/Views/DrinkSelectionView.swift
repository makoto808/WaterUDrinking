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
                        Image("waterBottle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                    }
                }
            }
    
  
            
            
        }
    }
}
        
//        ScrollView(.horizontal) {
//            HStack(spacing: 20) {
//                    Image("waterBottle.png")
//                    .resizable()
////                    Text("Item \($0)")
//                        .foregroundStyle(.white)
//                        .font(.largeTitle)
//                        .frame(width: 80, height: 80)
//                        .background(.red)
//                }
//            }
//        }
//    }

#Preview {
    DrinkSelectionView()
}
