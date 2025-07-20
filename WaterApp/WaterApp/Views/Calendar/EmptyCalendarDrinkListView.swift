//
//  EmptyCalendarDrinkListView.swift
//  WaterApp
//
//  Created by Gregg Abe on 6/26/25.
//

import SwiftUI

struct EmptyCalendarDrinkListView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Environment(DrinkListVM.self) private var drinkListVM
    
    @EnvironmentObject var purchaseManager: PurchaseManager
    
    let selectedDate: Date
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text(selectedDate.formatted(date: .long, time: .omitted))
                    .fontMediumTitle()
                    .padding(.top, 55)
                
                Text("You Are Dehydrated!")
                    .fontMediumTitle()
                    .multilineTextAlignment(.center)
                
                PremiumButtonToggle(
                    action: {
                        drinkListVM.selectedCalendarDate = selectedDate
                        drinkListVM.refreshFromCache(for: selectedDate, modelContext: modelContext)
                        dismiss()

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                            drinkListVM.showPastDrinkSheet = true
                        }
                    }
                ) {
                    HStack(spacing: 4) {
                        Text("+ Add")
                        if !purchaseManager.hasProAccess {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.red)
                                .font(.caption2)
                        }
                    }
                }
                .button1()
                
                Spacer(minLength: 20)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.bottom, 40)
        }
    }
}

//#Preview {
//    EmptyCalendarDrinkListView()
//}
