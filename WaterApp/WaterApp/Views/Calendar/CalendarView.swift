//
//  CalendarView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/26/25.
//

import SwiftUI

struct CalendarView: View {
    @State private var date = Date()
    
    var body: some View {
        VStack {
            
            BarChart()
            
            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
        }
        .padding(.horizontal)
    
        
        Button("Add Previous Drink", systemImage: "lock") {
            
        }
        .buttonBorderShape(.capsule)
        .buttonStyle(.borderedProminent)
        //make custom color button later
        //toggle systemImage if on premium account or not
    }
}

#Preview {
    CalendarView()
}
