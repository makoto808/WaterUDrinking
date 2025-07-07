//
//  NotificationView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/6/25.
//

import SwiftUI

struct NotificationView: View {
    @State private var reminder: [NotificationModel] = []
    @State private var showingAlarmSetViewSheet = false

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Reminders")
                    .fontMediumTitle()

                Spacer()
                
                Button {
                    showingAlarmSetViewSheet = true
                } label: {
                    Image(systemName: "plus")
                        .plusButton1()
                }
            }
            .padding([.horizontal, .top])
            
            List {
                if reminder.isEmpty {
                    Text("No reminders yet")
                        .fontSmallTitle2()
                        .listRowBackground(Color.clear)
                } else {
                    ForEach(reminder) { reminder in
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
        .sheet(isPresented: $showingAlarmSetViewSheet) {
            AlarmSetView { newAlarm in
                reminder.append(newAlarm)
                showingAlarmSetViewSheet = false
            }
            .presentationDetents([.fraction(0.75)])
        }
    }

    func deleteAlarms(at offsets: IndexSet) {
        reminder.remove(atOffsets: offsets)
    }
}

#Preview {
    NotificationView()
}
