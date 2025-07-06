//
//  AlarmSetView.swift
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

    var onSave: (NotificationModel) -> Void

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
                        .fontSmallTitle2()

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
                        let newAlarm = NotificationModel(time: reminderTime, label: labelText)
                        requestPermissionAndSchedule(for: newAlarm)
                        onSave(newAlarm)
                        dismiss()
                    }
                }
            }
        }
    }

    // MARK: - Notification Scheduling

    func requestPermissionAndSchedule(for model: NotificationModel) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                scheduleNotification(for: model)
            } else {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
                    if granted {
                        scheduleNotification(for: model)
                    }
                }
            }
        }
    }

    func scheduleNotification(for model: NotificationModel) {
        let content = UNMutableNotificationContent()
        content.title = model.label.isEmpty ? "Alarm" : model.label
        content.body = "Your alarm is going off!"
        content.sound = UNNotificationSound.defaultCriticalSound(withAudioVolume: 1.0)

        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: model.time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: model.id.uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}

#Preview {
    NavigationStack {
        AlarmSetView { newAlarm in
            // Preview handler — do nothing
            print("Saved alarm: \(newAlarm.label) at \(newAlarm.time)")
        }
    }
}
