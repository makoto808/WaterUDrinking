//
//  CloudSyncStatusView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/23/25.
//

import SwiftData
import SwiftUI

struct CloudSyncStatusView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.modelContext) private var modelContext

    @State private var lastSync: Date? = nil
    @State private var isSyncing = false
    @State private var error: Error?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("iCloud Backup")
                Spacer()
                syncStatusView
            }

            Button("Force Sync Now", action: triggerSync)
        }
        .padding()
        .onAppear(perform: fetchSyncStatus)
    }

    @ViewBuilder
    private var syncStatusView: some View {
        if isSyncing {
            ProgressView()
        } else if let lastSync = lastSync {
            Label {
                Text("Last sync: \(lastSync.formatted(.dateTime.hour().minute()))")
                    .font(.caption)
            } icon: {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(checkmarkColor)
            }
        } else {
            Label {
                Text("Not yet synced")
                    .font(.caption)
            } icon: {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.yellow)
            }
        }
    }

    private var checkmarkColor: Color {
        colorScheme == .light
            ? Color(red: 0.0, green: 0.25, blue: 0.0) : .green
    }

    private func triggerSync() {
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

    private func fetchSyncStatus() {
        // Load persisted sync state if applicable
    }
}
