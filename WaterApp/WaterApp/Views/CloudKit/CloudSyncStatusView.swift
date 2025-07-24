//
//  CloudSyncStatusView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/23/25.
//

import SwiftData
import SwiftUI

struct CloudSyncStatusView: View {
    @Environment(\.modelContext) private var modelContext

    @State private var lastSync: Date? = nil
    @State private var isSyncing = false
    @State private var error: Error?

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("iCloud Backup")
                Spacer()
                if isSyncing {
                    ProgressView()
                } else if let lastSync = lastSync {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text("Last sync: \(lastSync.formatted(.dateTime.hour().minute()))")
                        .font(.caption)
                } else {
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(.yellow)
                    Text("Not yet synced")
                        .font(.caption)
                }
            }

            Button("Force Sync Now") {
                triggerSync()
            }
        }
        .padding()
        .onAppear {
            fetchSyncStatus()
        }
    }

    func triggerSync() {
        isSyncing = true
        error = nil

        do {
            try modelContext.save()
            lastSync = Date()
        } catch {
            self.error = error
        }
        
        isSyncing = false
    }

    func fetchSyncStatus() {
        // You can load last sync from a persisted source if you have one,
        // or leave this empty for now.
    }
}
