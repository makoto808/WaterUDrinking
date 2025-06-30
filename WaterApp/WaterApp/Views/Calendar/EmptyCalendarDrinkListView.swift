//
//  EmptyCalendarDrinkListView.swift
//  WaterApp
//
//  Created by Gregg Abe on 6/26/25.
//

import SwiftUI

struct EmptyCalendarDrinkListView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Environment(DrinkListVM.self) private var drinkListVM
    
    let selectedDate: Date
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Spacer(minLength: 40)
                
                Text(selectedDate.formatted(date: .long, time: .omitted))
                    .fontUpdateDate()
                    .padding(.top)
                
                Text("You are dehydrated!")
                    .fontUpdateDate()
                    .multilineTextAlignment(.center)
                
                Button("+ Add") {
                    dismiss()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                        drinkListVM.navPath.removeLast()
                    }
                }
                .button1()
                
                Spacer(minLength: 20) // breathing room at bottom
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .padding(.bottom, 40) // gives room on short detents
        }
    }
}

//#Preview {
//    EmptyCalendarDrinkListView()
//}
