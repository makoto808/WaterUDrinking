//
//  PastDrinkView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/15/25.
//

import SwiftUI

struct PastDrinkView: View {
    @Environment(DrinkListVM.self) private var drinkListVM

    var body: some View {
        @Bindable var drinkListVM = drinkListVM

        VStack {
            Text("Choose Your Drink")
                .fontMediumTitle()
                .padding(.bottom, 30)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: -20) {
                    ForEach($drinkListVM.items) { $drink in
                        VStack(spacing: 10) {
                            Button {
                                drinkListVM.navPath.append(.drinkFillView(drink))
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
