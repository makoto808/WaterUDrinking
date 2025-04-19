//
//  CalendarView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/26/25.
//

import SwiftUI

struct CalendarView: View { //TODO: Access water streak (Apple Fitness rings style)
    @Environment(CalendarHomeVM.self) private var vm
    @State private var date = Date()
    
    var body: some View {
        VStack {
            // TODO: - Figure out how to get the date of whatever date "button" was tapped so we can pass it to vm.getCachedItems(for date: Date)
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
        .background(Color.backgroundWhite.ignoresSafeArea())
    }
}

#Preview {
    CalendarView()
}
