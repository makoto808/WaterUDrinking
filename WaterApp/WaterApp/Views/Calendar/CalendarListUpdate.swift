//
//  CalendarListUpdate.swift
//  WaterApp
//
//  Created by Gregg Abe on 6/25/25.
//

import SwiftData
import SwiftUI

struct CalendarListUpdate: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Environment(CalendarHomeVM.self) private var calendarVM
    @Environment(DrinkListVM.self) private var drinkListVM
    
    @EnvironmentObject var purchaseManager: PurchaseManager

    @State private var drinks: [CachedDrinkItem] = []
    
    @Bindable var calendarVMBindable: CalendarHomeVM
    
    let selectedDate: Date
    
    var body: some View {
        VStack {
            if drinks.isEmpty {
                EmptyCalendarDrinkListView(selectedDate: selectedDate)
            } else {
                Spacer(minLength: 40)
                
                Text(selectedDate.formatted(date: .long, time: .omitted))
                    .fontMediumTitle()
                    .padding(.top)
                
                Spacer(minLength: 30)
                
                PremiumButtonToggle(
                    action: {
                        drinkListVM.selectedCalendarDate = selectedDate
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
                
                ScrollView {
                    Spacer(minLength: 20)
                    VStack(spacing: 24) {
                        
                        ForEach(drinks.sorted(by: { $0.date < $1.date }), id: \.id) { drink in
                            CalendarDrinkRow(
                                drink: drink,
                                onDelete: {
                                    calendarVM.drinkToDelete = drink
                                    calendarVM.showAlert = true
                                }
                            )
                        }
                    }
                    .alert("Delete This Drink?", isPresented: $calendarVMBindable.showAlert) {
                        Button("Cancel", role: .cancel) { }
                        Button("Delete", role: .destructive) {
                            if let drink = calendarVM.drinkToDelete {
                                deleteDrink(drink)
                                calendarVM.drinkToDelete = nil
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .onAppear {
            drinks = calendarVM.fetchDrinks(for: selectedDate)
        }
    }
    
    private func deleteDrink(_ drink: CachedDrinkItem) {
        calendarVM.deleteDrink(drink, drinkListVM: drinkListVM)
        drinks = calendarVM.fetchDrinks(for: selectedDate)
    }
}
