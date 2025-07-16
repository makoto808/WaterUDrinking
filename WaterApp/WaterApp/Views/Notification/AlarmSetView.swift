//
//  AlarmSetView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/6/25.
//

import SwiftUI
import UserNotifications
import SwiftData

struct AlarmSetView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(NotificationVM.self) private var notificationVM

    @State private var reminderTime = Date()
    @State private var labelText = ""
    @State private var showAlert = false

    var onSave: (NotificationModel) -> Void

    var body: some View {
        ZStack {
            Color("AppBackgroundColor")

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

                    TextField("Drink Reminder", text: $labelText)
                        .onChange(of: labelText) {
                            if labelText.count > 32 {
                                labelText = String(labelText.prefix(32))
                            }
                        }
                        .alarmSetLabel()

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
                        saveReminder()
                    }
                }
            }
            .alert("Label Is Missing!", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Please enter a label for the reminder before saving.")
            }
        }
    }

    private func saveReminder() {
        let trimmed = labelText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmed.isEmpty else {
            showAlert = true
            return
        }

        let newReminder = NotificationModel(time: reminderTime, label: trimmed)

        notificationVM.insertReminder(newReminder)

        if newReminder.isEnabled {
            notificationVM.requestPermissionAndSchedule(for: newReminder)
        }

        onSave(newReminder)
        dismiss()
    }
}

//
//#Preview {
//    NavigationStack {
//        AlarmSetView { newAlarm in
//            // Preview handler — do nothing
//            print("Saved alarm: \(newAlarm.label) at \(newAlarm.time)")
//        }
//    }
//}
