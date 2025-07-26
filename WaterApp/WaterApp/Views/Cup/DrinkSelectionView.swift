//
//  DrinkSelectionView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/23/25.
//

import SwiftUI

struct DrinkSelectionView: View {
    @Environment(DrinkListVM.self) private var drinkListVM
    
    @EnvironmentObject var purchaseManager: PurchaseManager
    
    var isFromHome: Bool

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
                                    .drinkFillSelectionResize()
                            }

                            Text(drink.name)
                                .fontSmallTitle2()
                        }
                        .padding(.bottom, 40)
                    }
                    .scrollTransition { content, phase in
                        content
                            .opacity(phase.isIdentity ? 1.0 : 0.0)
                            .offset(y: phase.isIdentity ? 0 : 50)
                    }
                }
            }
            .onAppear {
                if isFromHome {
                    drinkListVM.selectedCalendarDate = nil
                }
            }
        }
    }
}

#Preview {
    let drinkListVM = DrinkListVM()

    DrinkSelectionView(isFromHome: true)
        .environment(drinkListVM)
}

// TODO: Ability to reorder and add new drinks to DrinkSelectionView

