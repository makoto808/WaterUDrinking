//
//  CloudSync.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/23/25.
//

import SwiftUI
import SwiftData

struct CloudSync: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(DrinkListVM.self) private var drinkListVM
    
    @State private var isSyncing = false
    @AppStorage("lastSyncDate") private var lastSyncDate: Double = 0
    
    var body: some View {
        ZStack {
            // Sky background
            LinearGradient(colors: [.blue.opacity(0.5), .blue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            // Cloud animation layer
            CloudMotionView()
            
            VStack(spacing: 24) {
                Spacer()
                
                VStack(spacing: 8) {
                    HStack {
                        Text("iCloud Backup Status")
                            .fontProTitle()
                        Spacer()
                    }
                    
                    HStack {
                        if isSyncing {
                            ProgressView()
                        } else if lastSyncDate > 0 {
                            Image(systemName: "checkmark.icloud.fill")
                                .foregroundColor(.green)
                            Text("Last synced: \(formattedDate)")
                                .fontSmallTitle2()
                                .foregroundColor(.secondary)
                        } else {
                            Image(systemName: "xmark.icloud.fill")
                                .foregroundColor(.red)
                            Text("Never synced")
                                .fontSmallTitle2()
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .padding(.bottom, 25)
                    
                    Button(action: {
                        Task { await triggerSync() }
                    }) {
                        Text("Backup Bottles")
                            .button1()
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                Spacer()
            }
        }
        .backChevronButton(using: drinkListVM)
    }
    
    var formattedDate: String {
        let date = Date(timeIntervalSince1970: lastSyncDate)
        return date.formatted(.dateTime.hour().minute())
    }
    
    func triggerSync() async {
        isSyncing = true
        do {
            try modelContext.save()
            lastSyncDate = Date().timeIntervalSince1970
        } catch {
            print("Sync failed: \(error)")
        }
        isSyncing = false
    }
}

#Preview {
    CloudSync()
        .modelContainer(
            try! ModelContainer(
                for: Schema([CachedDrinkItem.self, UserGoal.self, NotificationModel.self])
            )
        )
        .environment(DrinkListVM())
}
