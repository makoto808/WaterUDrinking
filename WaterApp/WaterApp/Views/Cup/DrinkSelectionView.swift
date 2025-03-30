//
//  DrinkSelectionView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/23/25.
//

import SwiftUI

struct BounceButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 3.0 : 1.0)
    }
}

struct DrinkSelectionView: View {
    @State private var drinkImage: [String] = ["waterBottle", "tea", "coffee", "soda", "juice", "milk", "energyDrink", "beer"]
    @State private var drinkName: [String] = ["Water", "Tea", "Coffee", "Soda", "Juice", "Milk", "Energy Drink", "Beer"]
    
    @State private var scale = 1.0
    @State private var selected: Bool = false
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: -20) {
                    ForEach(drinkImage.indices, id: \.self) { drink in
                        VStack(spacing: 10) {
                            Button {
                                print(drinkName[drink])
                            } label: {
                                Image(drinkImage[drink])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 110)
                            }
                        
                            .buttonStyle(BounceButtonStyle())
                                
//                            .onTapGesture {
//                                selected.toggle()
//                            }
//                            .scaleEffect(self.selected ? 3 : 1)
//                            } label : {
//                                Image(drinkImage[drink])
//                                    .resizable()
//                                    .scaledToFit()
//                                    
////                                    .buttonStyle(BounceButtonStyle())
//                                    .frame(width: 150, height: 110)
//                                
//                                  .animation(.default, value: scale)
//                                
//                            }
//                            
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


//    .aspectRatio(contentMode: .fill)
//    .aspectRatio(contentMode: zoomed ? .fill : .fill)

// need to create array of drink images and titles
// add in button after 8th drink for other options of drinks. will not replace anything in first 8

#Preview {
    DrinkSelectionView()
}

//struct MenuItem: Identifiable {
//    let id = UUID().uuidString
//    let name: String
//    let img: String




