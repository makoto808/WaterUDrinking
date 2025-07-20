//
//  PurchaseRow.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/16/25.
//

import StoreKit
import SwiftUI

struct PurchaseRow: View {
    let title: String
    let description: String
    let action: () -> Void
    var isLoading: Bool = false

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fontSmallTitle()
                
                Text(description)
                    .fontSmallTitle()
            }
            
            Spacer()
            
            Button(action: {
                if !isLoading {
                    action()
                }
            }) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(width: 24, height: 24)
                } else {
                    Text("Purchase")
                        .fontSmallTitle()
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(isLoading)
        }
        .padding()
        .background(Color("PurchaseRowBackground"))
        .cornerRadius(12)
    }
}
