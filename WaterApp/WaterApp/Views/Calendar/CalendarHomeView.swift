//
//  CalendarHomeView.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/16/25.
//

import SwiftUI

struct CalendarHomeView: View { //TODO: Access water streak (Apple Fitness rings style)
    @Environment(CalendarHomeVM.self) private var vm
    
    var body: some View {
        ZStack {
            Color.backgroundWhite.ignoresSafeArea()
            
            VStack {
                BarChart()
                
                //better to implemet reset button here instead?
//                CalendarView()
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    CalendarHomeView()
}
