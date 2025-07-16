//
//  NotificationView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/6/25.
//

import SwiftData
import SwiftUI

struct NotificationView: View {
    @Environment(\.modelContext) private var context
    @Environment(DrinkListVM.self) private var drinkListVM
    @Environment(NotificationVM.self) private var notificationVM
    
    @State private var showingAlarmSetViewSheet = false
    
    var body: some View {
        VStack(spacing: 0) {
            List {
                if notificationVM.reminders.isEmpty {
                    Text("No reminders yet")
                        .fontSmallTitle2()
                        .listRowBackground(Color.clear)
                } else {
                    ForEach(notificationVM.reminders) { reminder in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(reminder.time, style: .time)
                                    .fontOzLabel()
                                
                                Text(reminder.label)
                                    .fontSmallTitle2()
                            }
                            Spacer()
                            Toggle("", isOn: Binding(
                                get: { reminder.isEnabled },
                                set: { notificationVM.toggleReminder(reminder, isOn: $0) }
                            ))
                            .labelsHidden()
                            .tint(Color.cyan)
                        }
                        .padding(.vertical, 4)
                        .opacity(reminder.isEnabled ? 1.0 : 0.3)
                        .animation(.easeInOut(duration: 0.3), value: reminder.isEnabled)
                        .listRowBackground(Color.clear)
                    }
                    .onDelete(perform: notificationVM.deleteReminders)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color("AppBackgroundColor"))
        }
        .background(Color("AppBackgroundColor"))
        .onAppear {
            notificationVM.loadReminders()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    drinkListVM.navPath.removeLast()
                } label: {
                    Image(systemName: "chevron.backward")
                        .backButton1()
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Reminders")
                    .fontBarLabel()
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingAlarmSetViewSheet = true
                } label: {
                    Image(systemName: "plus")
                        .plusButton1()
                }
            }
        }
        .sheet(isPresented: $showingAlarmSetViewSheet) {
            NavigationStack {
                AlarmSetView { _ in
                    notificationVM.loadReminders()
                    showingAlarmSetViewSheet = false
                }
                .environment(notificationVM)
            }
            .presentationDetents([.fraction(0.75)])
        }
    }
}

//#Preview {
//    NavigationStack {
//        NotificationView()
//            .environment(DrinkListVM())
//    }
//}
