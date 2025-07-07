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
                    // Reload reminders when new alarm saved
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
            reminders = try context.fetch(fetchDescriptor)
        } catch {
            print("Failed to fetch reminders: \(error)")
            reminders = []
        }
    }

    func deleteAlarms(at offsets: IndexSet) {
        for index in offsets {
            context.delete(reminders[index])
        }
        do {
            try context.save()
            loadReminders()  // Refresh after delete
        } catch {
            print("Failed to delete reminders: \(error)")
        }
    }
}

#Preview {
    NavigationStack {
        NotificationView()
            .environment(DrinkListVM())
    }
}
