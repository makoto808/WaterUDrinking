//
//  PurchaseRow.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/16/25.
//

import SwiftUI
import StoreKit

struct PurchaseRow: View {
    let title: String
    let description: String
    let action: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fontSmallTitle()
                Text(description)
                    .fontSmallTitle()
            }
            Spacer()
            Button("Purchase") {
                action()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(Color.waterBlue)
        .cornerRadius(12)
    }
}
