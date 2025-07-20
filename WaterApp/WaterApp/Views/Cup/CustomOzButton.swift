//
//  CustomOzButton.swift
//  WaterApp
//
//  Created by Gregg Abe on 6/30/25.
//

import SwiftUI

struct CustomOzButton: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Environment(DrinkListVM.self) private var drinkListVM
    
    @EnvironmentObject var purchaseManager: PurchaseManager
    
    @Binding var text: String
    let item: DrinkItem
    
    var body: some View {
        PremiumButtonToggle(
            action: {
                guard let customAmount = Double(text), customAmount > 0 else {
                    drinkListVM.showAlert = true
                    return
                }
                
                if let newItem = drinkListVM.parseNewCachedItem(for: item, volume: customAmount) {
                    modelContext.insert(newItem)
                    do {
                        try modelContext.save()
                        drinkListVM.refreshFromCache(for: newItem.date, modelContext: modelContext)
                    } catch {
                        print("Failed to save: \(error.localizedDescription)")
                    }
                    
                    text = ""
                    dismiss()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                        drinkListVM.navPath.removeLast()
                    }
                } else {
                    drinkListVM.showAlert = true
                }
            }
        ) {
            HStack(spacing: 4) {
                if purchaseManager.hasProAccess {
                    Text("+ Custom Amount")
                } else {
                    Image(systemName: "lock.fill")
                        .foregroundColor(.red)
                        .font(.caption2)
                }
            }
            .button1()
        }
    }
}
