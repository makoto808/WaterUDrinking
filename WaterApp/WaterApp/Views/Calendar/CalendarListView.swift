//
//  CalendarListView.swift
//  WaterApp
//
//  Created by Gregg Abe on 6/23/25.
//

import SwiftUI

struct CalendarListView: View {
    let drinks: [CachedDrinkItem]
    let totalOunces: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Total: \(totalOunces, specifier: "%.0f") oz")
                .font(.headline)
                .padding(.top)

            ForEach(drinks, id: \.id) { drink in
                HStack(spacing: 12) {
                    Image(drink.img)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.blue)

                    VStack(alignment: .leading) {
                        Text(drink.name)
                            .font(.subheadline)
                        Text("\(drink.volume, specifier: "%.0f") oz")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }

                    Spacer()
                }
                .padding(.vertical, 4)
            }
        }
        .transition(.move(edge: .top).combined(with: .opacity))
        .padding(.top)
    }
}


//#Preview {
//    CalendarListView()
//}

