//
//  CalendarView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/26/25.
//

import SwiftUI

struct CalendarView: View {
    //TODO: Access previous water data, show list of drinks consumed, show CupView of that day.
    @Environment(CalendarHomeVM.self) private var vm
    
    @State private var date = Date()
    
    var body: some View {
        VStack {
            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            
            Button("Add Previous Drink", systemImage: "lock") {
                //TODO: Toggle systemImage if on premium account or not
            }
            .buttonCapsule()
        }
        .padding(.horizontal)
        .background(Color.backgroundWhite.ignoresSafeArea())
    }
}

#Preview {
    CalendarView()
}
