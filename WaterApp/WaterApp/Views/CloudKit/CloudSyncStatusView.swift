//
//  CloudSyncStatusView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/23/25.
//

import CloudKit
import SwiftData
import SwiftUI

struct CloudSyncStatusView: View {
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

        Task {
            do {
                try await ModelContext.current?.container?.triggerCloudSync()
                lastSync = Date()
            } catch {
                self.error = error
            }
            isSyncing = false
        }
    }

    func fetchSyncStatus() {
        // There's no official API for last sync time in SwiftData yet,
        // so we simulate by storing a "last sync" manually or assuming success on button press.
        // You can persist `lastSync` with @AppStorage or other persistent flag.
    }
}


#Preview {
    CloudSyncStatusView()
}
