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
        VStack(spacing: 0) {
            HStack {
                Text("Alarms")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                Button {
                    showingAlarmSetViewSheet = true
                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .padding(8)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding([.horizontal, .top])

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
        }
        .sheet(isPresented: $showingAlarmSetViewSheet) {
            AlarmSetView { newAlarm in
                alarms.append(newAlarm)
                showingAlarmSetViewSheet = false
            }
            .presentationDetents([.fraction(0.75)])
        }
        .background(Color.backgroundWhite)
    }

    func deleteAlarms(at offsets: IndexSet) {
        alarms.remove(atOffsets: offsets)
    }
}

#Preview {
    NotificationView()
}
