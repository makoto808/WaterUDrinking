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

    @State private var drinks: [CachedDrinkItem] = []
    
    let selectedDate: Date

    var body: some View {
        VStack {
            Spacer(minLength: 20)
            Text(selectedDate.formatted(date: .long, time: .omitted))
                .fontUpdateDate()
                .padding(.top)
            
            Spacer(minLength: 35)
            Button("+ Add") {
                
            }
            .button1()
            
            if drinks.isEmpty {
                Text("You are dehydrated!")
                    .fontSmall()
            } else {
                Spacer(minLength: 20)
                ScrollView {
                    Spacer(minLength: 20)
                    VStack(spacing: 24) {
                        
                        ForEach(drinks, id: \.id) { drink in
                            HStack(alignment: .center, spacing: 12) {
                                Image(drink.img)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(drink.name)
                                        .fontBarLabel()
                                    
                                    Text("\(drink.volume, specifier: "%.1f") oz")
                                        .fontBarLabel2()
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .onAppear {
            fetchDrinksForSelectedDate()
        }
    }


    private func fetchDrinksForSelectedDate() {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: selectedDate)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!

        let descriptor = FetchDescriptor<CachedDrinkItem>(
            predicate: #Predicate {
                $0.date >= startOfDay && $0.date < endOfDay
            },
            sortBy: [.init(\.date, order: .forward)]
        )

        do {
            drinks = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed: \(error)")
        }
    }
}

struct CalendarListUpdatePreviewMock: View {
    let mockDrinks = [
        CachedDrinkItem(date: .now, name: "Water", img: "waterBottle", volume: 12.0, arrayOrderValue: 0),
        CachedDrinkItem(date: .now, name: "Tea", img: "tea", volume: 8.0, arrayOrderValue: 1),
        CachedDrinkItem(date: .now, name: "Water", img: "beer", volume: 12.0, arrayOrderValue: 0),
        CachedDrinkItem(date: .now, name: "Tea", img: "soda", volume: 8.0, arrayOrderValue: 1),
        CachedDrinkItem(date: .now, name: "Water", img: "energyDrink", volume: 12.0, arrayOrderValue: 0),
        CachedDrinkItem(date: .now, name: "Tea", img: "soda", volume: 8.0, arrayOrderValue: 1)
    ]
    
    var body: some View {
        VStack {
            Spacer(minLength: 20)
            Text(Date().formatted(date: .long, time: .omitted))
                .fontUpdateDate()
                .padding(.top)
            
            Spacer(minLength: 35)
            Button("+ Add") {
                
            }
            .button1()
            
            Spacer(minLength: 20)
            ScrollView {
                Spacer(minLength: 20)
                VStack(spacing: 24) {
                    
                    ForEach(mockDrinks, id: \.id) { drink in
                        HStack(alignment: .center, spacing: 12) {
                            Image(drink.img)
                                .resizable()
                                .frame(width: 60, height: 60)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(drink.name)
                                    .fontBarLabel()
                                
                                Text("\(drink.volume, specifier: "%.1f") oz")
                                    .fontBarLabel2()
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal)
//                .background(Color.red.opacity(0.05)) // Debug: remove later
            }
        }
    }
}


#Preview {
    struct PreviewWrapper: View {
        var body: some View {
            CalendarListUpdatePreviewMock()
        }
    }

    return PreviewWrapper()
}


