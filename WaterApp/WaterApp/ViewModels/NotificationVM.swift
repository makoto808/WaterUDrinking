//
//  NotificationVM.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/6/25.
//

import Foundation
import Observation
import SwiftUI
import SwiftData
import UserNotifications

@Observable
class NotificationVM {
    var reminders: [NotificationModel] = []
    private var context: ModelContext

    init(context: ModelContext) {
        self.context = context
        loadReminders()
    }

    // MARK: - Load Data
    
    // Fetch reminders from the SwiftData store and update the `reminders` array
    func loadReminders() {
        do {
            let fetchDescriptor = FetchDescriptor<NotificationModel>(sortBy: [SortDescriptor(\.time)])
            let fetched = try context.fetch(fetchDescriptor)
            DispatchQueue.main.async {
                self.reminders = fetched
            }
        } catch {
            print("Failed to fetch reminders: \(error)")
            DispatchQueue.main.async {
                self.reminders = []
            }
        }
    }

    // MARK: - Insert / Delete / Save
    func insertReminder(_ reminder: NotificationModel) {
        context.insert(reminder)
        saveContext()
        loadReminders()
    }

    func deleteReminders(at offsets: IndexSet) {
        for index in offsets {
            let reminder = reminders[index]
            cancelNotification(for: reminder)
            context.delete(reminder)
        }
        saveContext()
        loadReminders()
    }

    func saveContext() {
        do {
            try context.save()
            loadReminders()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
    // MARK: - Toggle
    
    // Enable or disable a reminder and update local notification accordingly
    func toggleReminder(_ reminder: NotificationModel, isOn: Bool) {
        reminder.isEnabled = isOn
        saveContext()

        if isOn {
            scheduleNotification(for: reminder)
        } else {
            cancelNotification(for: reminder)
        }
    }
    
    // MARK: - Notification Handling

    // Schedule a local notification for the given reminder
    func scheduleNotification(for model: NotificationModel) {
        let content = UNMutableNotificationContent()
        content.title = "💧 Time to Hydrate!"
        content.body = model.label.isEmpty ? "Alarm" : model.label
        content.sound = UNNotificationSound.defaultCriticalSound(withAudioVolume: 1.0)

        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: model.time)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: model.id.uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    // Request notification permissions and schedule the reminder
    func requestPermissionAndSchedule(for model: NotificationModel) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                DispatchQueue.main.async {
                    self.scheduleNotification(for: model)
                }
            } else {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
                    if granted {
                        DispatchQueue.main.async {
                            self.scheduleNotification(for: model)
                        }
                    }
                }
            }
        }
    }

    // Cancel the local notification associated with a reminder
    func cancelNotification(for model: NotificationModel) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [model.id.uuidString])
    }
}
