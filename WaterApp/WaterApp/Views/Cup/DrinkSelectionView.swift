//
//  DrinkSelectionView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/23/25.
//

import SwiftUI

struct DrinkSelectionView: View {
    @Environment(DrinkListVM.self) private var drinkListVM

    var body: some View {
        @Bindable var drinkListVM = drinkListVM

        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: -20) {
                    ForEach($drinkListVM.items) { $drink in
                        VStack(spacing: 10) {
                            Button {
                                drinkListVM.navPath.append(.drinkFillView(drink))
                            } label: {
                                Image(drink.img)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 110)
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
        .background(Color.backgroundWhite)
    }
}

#Preview {
    DrinkSelectionView()
        .environment(DrinkListVM())
}

// TODO: Ability to reorder and add new drinks to DrinkSelectionView

