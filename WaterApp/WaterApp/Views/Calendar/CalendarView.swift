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
            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
        }
        
        Button("Add Previous Drink") {
            
        }
        .buttonBorderShape(.capsule)
        .buttonStyle(.borderedProminent)
        //make custom color button later
    }
}

#Preview {
    CalendarView()
}
