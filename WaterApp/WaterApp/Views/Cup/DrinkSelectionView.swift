//
//  DrinkSelectionView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/23/25.
//

import SwiftUI

struct DrinkSelectionView: View {
    @Environment(DrinkListVM.self) private var drinkListVM
    @Environment(DrinkMenuVM.self) private var drinkMenuVM
    @EnvironmentObject var purchaseManager: PurchaseManager
    
    var isFromHome: Bool

    var body: some View {
        @Bindable var drinkListVM = drinkListVM

        VStack {
            Spacer(minLength: 30)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: -20) {
                    ForEach(drinkMenuVM.arrangedDrinks.prefix(8)) { drink in
                        VStack(spacing: 10) {
                            Button {
                                let hydrationRate = drinkListVM.hydrationRateForDrink(named: drink.name)
                                let category = drinkListVM.categoryForDrink(named: drink.name)
                                let drinkItem = DrinkItem(
                                    name: drink.name,
                                    img: drink.img,
                                    volume: 0,
                                    hydrationRate: hydrationRate,
                                    category: category
                                )
                                drinkListVM.navPath.append(.drinkFillView(drinkItem))
                            } label: {
                                Image(drink.img)
                                    .drinkFillSelectionResize()
                            }

                            Text(drink.name)
                                .fontSmallTitle2()
                        }
                        .scrollTransition { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1.0 : 0.0)
                                .offset(y: phase.isIdentity ? 0 : 50)
                        }
                    }

                    VStack(spacing: 10) {
                        Button {
                            drinkListVM.navPath.append(.drinkMenuView)
                        } label: {
                            Image("plusIcon")
                                .drinkFillSelectionResize()
                                .scaleEffect(1.4)
                        }

                        Text("Add Drink")
                            .fontSmallTitle2()
                    }
                    .scrollTransition { content, phase in
                        content
                            .opacity(phase.isIdentity ? 1.0 : 0.0)
                            .offset(y: phase.isIdentity ? 0 : 50)
                    }
                }
                .padding(.bottom, 40)
            }
            .onAppear {
                if isFromHome {
                    drinkListVM.selectedCalendarDate = nil
                }
            }
        }
        .frame(height: 160)
    }
}

//#Preview {
//    let drinkListVM = DrinkListVM()
//    let drinkMenuVM = DrinkMenuVM(context: ModelContext)
//    let purchaseManager = PurchaseManager()
//
//    DrinkSelectionView(isFromHome: true)
//        .environment(drinkListVM)
//        .environment(drinkMenuVM)
//        .environmentObject(purchaseManager)
//}
