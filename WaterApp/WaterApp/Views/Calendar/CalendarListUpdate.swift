//
//  CalendarListUpdate.swift
//  WaterApp
//
//  Created by Gregg Abe on 6/25/25.
//

import SwiftUI

struct CalendarListUpdate: View {
    let selectedDate: Date

    var body: some View {
        VStack(spacing: 16) {
            Text("Manage Drinks Here")
                .fontSmall()
            
            Text(selectedDate.formatted(date: .long, time: .omitted))
                .fontSmall()
             
            // Add / Delete controls here
        }
        .padding()
    }
}

#Preview {
    CalendarListUpdate(selectedDate: Date())
}
