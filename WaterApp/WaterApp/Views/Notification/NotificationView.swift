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

    @State private var reminders: [NotificationModel] = []
    @State private var showingAlarmSetViewSheet = false

    var body: some View {
        VStack(spacing: 0) {
            List {
                if reminders.isEmpty {
                    Text("No reminders yet")
                        .fontSmallTitle2()
                        .listRowBackground(Color.clear)
                } else {
                    ForEach(reminders) { reminder in
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
                                set: { newValue in
                                    reminder.isEnabled = newValue
                                    saveContext()
                                }
                            ))
                            .labelsHidden()
                            .tint(Color.cyan)
                        }
                        .padding(.vertical, 4)
                        .opacity(reminder.isEnabled ? 1.0 : 0.3) 
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
                    loadReminders()
                    showingAlarmSetViewSheet = false
                }
                .environment(\.modelContext, context)
            }
            .presentationDetents([.fraction(0.75)])
        }
        .onAppear {
            loadReminders()
        }
    }

    func loadReminders() {
        do {
            let fetchDescriptor = FetchDescriptor<NotificationModel>(sortBy: [SortDescriptor(\.time)])
            let fetched = try context.fetch(fetchDescriptor)
            DispatchQueue.main.async {
                reminders = fetched
                print("Loaded \(reminders.count) reminders")
            }
        } catch {
            print("Failed to fetch reminders: \(error)")
            DispatchQueue.main.async {
                reminders = []
            }
        }
    }

    func deleteAlarms(at offsets: IndexSet) {
        for index in offsets {
            context.delete(reminders[index])
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
}

#Preview {
    NavigationStack {
        NotificationView()
            .environment(DrinkListVM())
    }
}
