//
//  NotificationView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/6/25.
//

import SwiftUI

struct NotificationView: View {
    @Environment(DrinkListVM.self) private var drinkListVM
    
    @State private var reminder: [NotificationModel] = []
    @State private var showingAlarmSetViewSheet = false

    var body: some View {
        VStack(spacing: 0) {
            List {
                if reminder.isEmpty {
                    Text("No reminders yet")
                        .fontSmallTitle2()
                        .listRowBackground(Color.clear)
                } else {
                    ForEach(reminder.sorted(by: { $0.time < $1.time })) { reminder in
                        VStack(alignment: .leading) {
                            Text(reminder.label)
                                .font(.headline)
                            Text(reminder.time, style: .time)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                        .listRowBackground(Color.clear)
                    }
                    .onDelete(perform: deleteAlarms)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.backgroundWhite)
        }
        .background(Color.backgroundWhite)
        .navigationBarBackButtonHidden(true)
             .toolbar {
                 ToolbarItem(placement: .topBarLeading) {
                     Button {
                         drinkListVM.navPath.removeLast()
                     } label: {
                         Image(systemName: "chevron.backward")
                             .backButton1()
                             .padding(.top, 40)
                     }
                 }
                 
                 ToolbarItem(placement: .principal) {
                     Text("Reminders")
                         .fontBarLabel()
                         .padding(.top, 40)
                 }
                 
                 ToolbarItem(placement: .topBarTrailing) {
                     Button {
                         showingAlarmSetViewSheet = true
                     } label: {
                         Image(systemName: "plus")
                             .plusButton1()
                             .padding(.top, 40)
                     }
                 }
             }
        .sheet(isPresented: $showingAlarmSetViewSheet) {
            NavigationStack {
                AlarmSetView { newAlarm in
                    reminder.append(newAlarm)
                    showingAlarmSetViewSheet = false
                }
            }
            .presentationDetents([.fraction(0.75)])
        }
    }

    func deleteAlarms(at offsets: IndexSet) {
        reminder.remove(atOffsets: offsets)
    }
}

#Preview {
    NavigationStack {
        NotificationView()
            .environment(DrinkListVM())
    }
}
