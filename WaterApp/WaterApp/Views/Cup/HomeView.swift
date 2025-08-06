//
//  HomeView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/22/25.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Environment(DrinkListVM.self) private var drinkListVM
    
    @EnvironmentObject var purchaseManager: PurchaseManager
    
    var body: some View {
        VStack(spacing: 0) {
            TitleView()
                .padding(.top, 10)
            
            Spacer(minLength: 50)
            
            CupView()
            
            Spacer(minLength: 1)
            
            DrinkSelectionView(isFromHome: true)
            
            Spacer(minLength: 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("AppBackgroundColor"))
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    drinkListVM.navPath.append(.calendar)
                } label: {
                    Image("calendarIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28, height: 28)
                        .padding(.horizontal, 6)
                        .padding(.top, 6)
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    drinkListVM.navPath.append(.settings)
                } label: {
                    Image("gearIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .padding(.horizontal, 6)
                        .padding(.top, 6)
                }
            }
        }
        .onAppear {
            drinkListVM.modelContext = modelContext
            drinkListVM.refreshTodayItems(modelContext: modelContext)
        }
        .navigationBarBackButtonHidden(true)
    }
}
