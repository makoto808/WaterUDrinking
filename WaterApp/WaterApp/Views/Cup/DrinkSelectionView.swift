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
                            // TODO: Make plus image icon on photoshop
                            Image(systemName: "plus.circle.fill")
                                .drinkFillSelectionResize()
                                .foregroundStyle(.blue)
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

#Preview {
    let drinkListVM = DrinkListVM()

    DrinkSelectionView(isFromHome: true)
        .environment(drinkListVM)
}

// TODO: Ability to reorder and add new drinks to DrinkSelectionView

