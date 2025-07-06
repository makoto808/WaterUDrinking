//
//  NotificationView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/6/25.
//

import SwiftUI

struct NotificationView: View {
    @State private var alarms: [NotificationModel] = []
    @State private var showingAlarmSetViewSheet = false

    var body: some View {
        NavigationStack {
            List {
                if alarms.isEmpty {
                    Text("No alarms yet")
                        .foregroundStyle(.gray)
                } else {
                    ForEach(alarms) { alarm in
                        VStack(alignment: .leading) {
                            Text(alarm.label)
                                .font(.headline)
                            Text(alarm.time, style: .time)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete(perform: deleteAlarms)
                }
            }
            .navigationTitle("Alarms")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAlarmSetViewSheet = true
                    } label: {
                        Label("Add Alarm", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAlarmSetViewSheet) {
                AlarmSetView { newAlarm in
                    alarms.append(newAlarm)
                }
            }
        }
    }

    func deleteAlarms(at offsets: IndexSet) {
        alarms.remove(atOffsets: offsets)
    }
}

#Preview {
    NotificationView()
}
