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
        VStack(spacing: 16) {
            Text(selectedDate.formatted(date: .long, time: .omitted))
                .fontUpdateDate()
            
            if drinks.isEmpty {
                Spacer()
                
                Text("You are dehydrated!")
                    .fontSmall()
                
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(drinks, id: \.id) { drink in
                            HStack {
                                Image(drink.img)
                                    .resizable()
                                    .frame(width: 60, height: 60)

                                VStack(alignment: .leading) {
                                    Text(drink.name)
                                        .fontBarLabel()

                                    Text("\(drink.volume, specifier: "%.1f") oz")
                                        .fontSmall()
                                        .foregroundColor(.gray)
                                }

                                Spacer()
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .frame(maxHeight: 300) // optional: limit scroll height
            }
        }
        .padding()
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
        VStack(spacing: 16) {
            Spacer()

            Text(Date().formatted(date: .long, time: .omitted))
                .fontUpdateDate()

            Spacer()

            ForEach(mockDrinks, id: \.id) { drink in
                HStack {
                    Image(drink.img)
                        .resizable()
                        .frame(width: 60, height: 60)

                    VStack(alignment: .leading) {
                        Text(drink.name)
                            .fontBarLabel()

                        Text("\(drink.volume, specifier: "%.1f") oz")
                            .fontBarLabel2()
                            .foregroundColor(.gray)
                    }

                    Spacer()
                }
            }

            Spacer()
        }
        .padding()
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


