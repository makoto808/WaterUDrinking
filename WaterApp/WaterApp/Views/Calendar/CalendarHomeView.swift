//
//  CalendarHomeView.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/16/25.
//

import SwiftUI

struct CalendarHomeView: View { //TODO: Access water streak (Apple Fitness rings style)
    @State private var vm = CalendarHomeVM()
    
    var body: some View {
        ZStack {
            Color.backgroundWhite.ignoresSafeArea()
            
            VStack {
                BarChart()
                
                CalendarView()
            }
            .padding(.horizontal)
        }
        .environment(vm)
    }
}

#Preview {
    CalendarHomeView()
}
