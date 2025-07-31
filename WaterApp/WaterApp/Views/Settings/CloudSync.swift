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
            GradientBackgroundView()
            
            CloudMotionView()
            
            VStack(spacing: 12) {
                VStack(spacing: 8) {
                    HStack {
                        Text("iCloud Backup Status")
                            .fontProTitle()
                            .foregroundColor(.white)
                            .padding(.horizontal, 15)
                        Spacer()
                    }
                    
                    HStack(spacing: 15) {
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
                    .padding(.horizontal, 15)
                    .padding(.bottom, 25)
                    
                    Button(action: {
                        Task { await triggerSync() }
                    }) {
                        if isSyncing {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .padding()
                        } else {
                            Text("Backup Bottles")
                                .font(.custom("ArialRoundedMTBold", size: 18))
                                .fontWeight(.semibold)
                                .padding()
                        }
                    }
                    .disabled(isSyncing)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                }
                .padding(.horizontal)
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
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        do {
            try modelContext.save()
            lastSyncDate = Date().timeIntervalSince1970
        } catch {
            print("Sync failed: \(error)")
        }
        isSyncing = false
    }
}

//#Preview {
//    CloudSync()
//        .modelContainer(
//            try! ModelContainer(
//                for: Schema([CachedDrinkItem.self, UserGoal.self, NotificationModel.self])
//            )
//        )
//        .environment(DrinkListVM())
//}
