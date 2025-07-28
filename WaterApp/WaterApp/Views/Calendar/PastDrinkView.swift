//
//  PastDrinkView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/15/25.
//

import SwiftUI

struct PastDrinkView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(DrinkListVM.self) private var drinkListVM
    @Environment(DrinkMenuVM.self) private var drinkMenuVM
    
    var body: some View {
        @Bindable var drinkListVM = drinkListVM
        
        VStack {
            Text("Choose Your Drink")
                .fontMediumTitle()
                .padding(.bottom, 30)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: -20) {
                    ForEach(drinkMenuVM.arrangedDrinks.prefix(8)) { drink in
                        VStack(spacing: 10) {
                            Button {
                                let drinkItem = DrinkItem(name: drink.name, img: drink.img, volume: 0)
                                drinkListVM.navPath.append(.drinkFillView(drinkItem))
                                dismiss()
                            } label: {
                                Image(drink.img)
                                    .drinkFillSelectionResize()
                            }
                            
                            Text(drink.name)
                                .fontSmallTitle2()
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
