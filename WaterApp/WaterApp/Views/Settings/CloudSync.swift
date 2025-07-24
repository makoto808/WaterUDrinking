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
    @State private var waveOffset = Angle(degrees: 0)
    
    @AppStorage("lastSyncDate") private var lastSyncDate: Double = 0
    
    var body: some View {
        ZStack {
            Color("AppBackgroundColor").ignoresSafeArea()
            
            GeometryReader { geo in
                WaveMotion(offset: waveOffset, percent: 3.9 / 8.0)
                    .fill(Color(red: 0, green: 0.5, blue: 0.75, opacity: 0.5))
                    .frame(width: geo.size.width + 100)
                    .offset(x: -50)
                    .ignoresSafeArea()
                    .onAppear {
                        withAnimation(.linear(duration: 3.5).repeatForever(autoreverses: false)) {
                            waveOffset = Angle(degrees: 360)
                        }
                    }
            }
            
            VStack(spacing: 24) {
                Spacer()
                
                // ✅ iCloud Sync Status Indicator
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
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text("Last synced: \(formattedDate)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        } else {
                            Image(systemName: "exclamationmark.triangle")
                                .foregroundColor(.orange)
                            Text("Never synced")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    
                    Button(action: {
                        Task { await triggerSync() }
                    }) {
                        Text("Force Sync Now")
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                // 💌 Feedback Section
                Text("Tap Here to Email Us Your Ideas!")
                    .fontProTitle()
                    .padding(.bottom, 20)
                
                Button(action: {
                    // Add email action if desired
                }) {
                    Text("💌")
                        .font(.title)
                }
                
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
        .modelContainer(for: [UserGoal.self, CachedDrinkItem.self, NotificationModel.self])
        .environment(DrinkListVM())
}
