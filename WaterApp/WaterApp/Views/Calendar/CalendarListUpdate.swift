//
//  CalendarListUpdate.swift
//  WaterApp
//
//  Created by Gregg Abe on 6/25/25.
//

import SwiftData
import SwiftUI

struct CalendarListUpdate: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Environment(CalendarHomeVM.self) private var calendarVM
    @Environment(DrinkListVM.self) private var drinkListVM
    
    @Bindable var calendarVMBindable: CalendarHomeVM
    
    @State private var drinks: [CachedDrinkItem] = []
    
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
                
                Button("+ Add") {
                    drinkListVM.selectedCalendarDate = selectedDate
                    dismiss()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                        drinkListVM.navPath.removeLast()
                    }
                }
                .button1()
                
                ScrollView {
                    Spacer(minLength: 20)
                    VStack(spacing: 24) {
                        
                        ForEach(drinks.sorted(by: { $0.date > $1.date }), id: \.id) { drink in
                            CalendarDrinkRow(drink: drink) {
                                calendarVM.drinkToDelete = drink
                                calendarVM.showAlert = true
                            }
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

// MARK: - SAMPLE MOCK PREVIEW
//struct CalendarListUpdatePreviewMock: View {
//    let mockDrinks = [
//        CachedDrinkItem(date: .now, name: "Water", img: "waterBottle", volume: 12.0, arrayOrderValue: 0),
//        CachedDrinkItem(date: .now, name: "Tea", img: "tea", volume: 8.0, arrayOrderValue: 1),
//        CachedDrinkItem(date: .now, name: "Water", img: "beer", volume: 12.0, arrayOrderValue: 0),
//        CachedDrinkItem(date: .now, name: "Tea", img: "soda", volume: 8.0, arrayOrderValue: 1),
//        CachedDrinkItem(date: .now, name: "Water", img: "energyDrink", volume: 12.0, arrayOrderValue: 0),
//        CachedDrinkItem(date: .now, name: "Tea", img: "soda", volume: 8.0, arrayOrderValue: 1)
//    ]
//
//    var body: some View {
//        VStack {
//            if !mockDrinks.isEmpty {
//                Spacer(minLength: 20)
//
//                Text(Date().formatted(date: .long, time: .omitted))
//                    .fontUpdateDate()
//                    .padding(.top)
//
//                Text("")
//                Text("You are dehydrated!")
//                    .fontUpdateDate()
//
//                Button("+ Add") {
//
//                }
//                .button1()
//
//            } else {
//                Spacer(minLength: 30)
//
//                Text(Date().formatted(date: .long, time: .omitted))
//                    .fontUpdateDate()
//                    .padding(.top)
//
//                Spacer(minLength: 30)
//
//                Button("+ Add") {
//
//                }
//                .button1()
//
//                ScrollView {
//                    Spacer(minLength: 30)
//                    VStack(spacing: 24) {
//
//                        ForEach(mockDrinks, id: \.id) { drink in
//                            HStack(alignment: .center, spacing: 12) {
//                                Image(drink.img)
//                                    .resizable()
//                                    .frame(width: 60, height: 60)
//
//                                VStack(alignment: .leading, spacing: 4) {
//                                    Text(drink.name)
//                                        .fontBarLabel()
//
//                                    Text("\(drink.volume, specifier: "%.1f") oz")
//                                        .fontBarLabel2()
//                                        .foregroundColor(.gray)
//                                }
//
//                                Spacer()
//                            }
//                        }
//                    }
//                    .padding(.horizontal)
//                    //                .background(Color.red.opacity(0.05)) // Debug: remove later
//                }
//            }
//        }
//    }
//}
//
//
//#Preview {
//    struct PreviewWrapper: View {
//        var body: some View {
//            CalendarListUpdatePreviewMock()
//        }
//    }
//
//    return PreviewWrapper()
//}
//
//
