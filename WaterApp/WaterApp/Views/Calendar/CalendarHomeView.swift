//
//  CalendarHomeView.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/16/25.
//

import SwiftUI

struct CalendarHomeView: View { //TODO: Access water streak (Apple Fitness rings style)
    
    var body: some View {
        ZStack {
            Color.backgroundWhite.ignoresSafeArea()
            
            VStack {
                BarChart()
                
                CalendarView()
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    CalendarHomeView()
}
