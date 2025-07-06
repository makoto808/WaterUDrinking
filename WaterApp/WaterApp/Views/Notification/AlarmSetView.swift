//
//  NotificationView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/6/25.
//

import SwiftUI
import UserNotifications

struct AlarmSetView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var reminderTime = Date()
    @State private var labelText = "Alarm"
    @State private var showConfirmation = false

    var body: some View {
        ZStack {
            Color.backgroundWhite.ignoresSafeArea()
            
            VStack(spacing: 0) {
                DatePicker("", selection: $reminderTime, displayedComponents: [.hourAndMinute])
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(maxHeight: 200)
                    .clipped()
                    .padding(.top, 20)

                Divider()

                VStack(alignment: .leading, spacing: 6) {
                    Text("Label")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    TextField("Alarm Label", text: $labelText)
                        .textFieldStyle(.plain)
                        .font(.body)
                        .padding(.vertical, 8)

                    Divider()
                }
                .padding(.horizontal)
                .padding(.top, 30)

                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        requestPermissionAndSchedule()
                        dismiss()
                    }
                }
            }
        }
    }

    // MARK: - Notification Handling

    func requestPermissionAndSchedule() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                scheduleNotification()
            } else {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
                    if granted {
                        scheduleNotification()
                    }
                }
            }
        }
    }

    func scheduleNotification() {
        // Clear previous one (if editing single-alarm logic)
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["alarmReminder"])

        let content = UNMutableNotificationContent()
        content.title = labelText.isEmpty ? "Alarm" : labelText
        content.body = "Your alarm is going off!"
        content.sound = UNNotificationSound.defaultCriticalSound(withAudioVolume: 1.0)

        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute], from: reminderTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: "alarmReminder", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
}

#Preview {
    AlarmSetView()
}
