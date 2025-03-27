//
//  CalendarView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/26/25.
//

import SwiftUI

struct CalendarView: View {
    @State private var date = Date()
    
    let backgroundWhite = Color(red: 0.9373, green: 0.9607, blue: 0.9607)
    
    var body: some View {
        ZStack {
            Color.backgroundWhite.ignoresSafeArea()
            
            VStack {
                BarChart()
                
                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                //make custom color button later
                //able to make as apple fitness ring app?
                
                Button("Add Previous Drink", systemImage: "lock") {
                    //toggle systemImage if on premium account or not
                }
                .buttonBorderShape(.capsule)
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)
        }
//        .background(Color.backgroundWhite) "Does not ignore safe area for whatever              reason??
    }
}

#Preview {
    CalendarView()
}
