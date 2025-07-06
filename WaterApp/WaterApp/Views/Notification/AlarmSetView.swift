//
//  NotificationView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/6/25.
//

import SwiftUI
import UserNotifications

struct AlarmSetView: View {
    @State private var reminderTime = Date()
    @State private var isAlarmOn = false
    @State private var permissionGranted = false
    @State private var showConfirmation = false

    var body: some View {
        ZStack {
            Color.backgroundWhite.ignoresSafeArea()
            
            VStack(spacing: 40) {
                Text("Hydration Alarm")
                    .fontMediumTitle()
                    .padding(.top, 40)

                DatePicker("", selection: $reminderTime, displayedComponents: [.hourAndMinute])
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .frame(maxHeight: 200)

                Toggle(isOn: $isAlarmOn) {
                    Text("Enable Alarm")
                        .fontBarLabel()
                }
                .padding(.horizontal, 40)

                Button(action: {
                    if isAlarmOn {
                        requestPermissionAndSchedule()
                    } else {
                        cancelAllNotifications()
                        showConfirmation = false
                    }
                }) {
                    Text(isAlarmOn ? "Save Alarm" : "Cancel Alarm")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isAlarmOn ? Color.waterBlue : Color.red)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }

                if showConfirmation {
                    Text("Alarm scheduled for \(formattedTime(reminderTime))")
                        .foregroundColor(.green)
                }

                Spacer()
            }
            .navigationBarHidden(true)
        }
    }

    func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

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
        cancelAllNotifications()

        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.body = "Your alarm is going off!"
        content.sound = UNNotificationSound.defaultCriticalSound(withAudioVolume: 1.0)

        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute], from: reminderTime)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "alarmReminder", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            DispatchQueue.main.async {
                if error == nil {
                    showConfirmation = true
                }
            }
        }
    }

    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["alarmReminder"])
        showConfirmation = false
    }
}

struct AlarmSetView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}

#Preview {
    AlarmSetView()
}
