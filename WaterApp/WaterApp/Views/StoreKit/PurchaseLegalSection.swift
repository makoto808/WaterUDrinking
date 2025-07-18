//
//  PurchaseLegalSection.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/16/25.
//

import SwiftUI

struct PurchaseLegalSection: View {
    var body: some View {
        let footnoteSize = UIFont.preferredFont(forTextStyle: .footnote).pointSize
        
        VStack(alignment: .leading, spacing: 8) {
            Text("• Subscriptions auto-renew unless canceled at least 24 hours before the end of the current period.")
            Text("• Payment will be charged to your Apple ID account at confirmation of purchase.")
            
            Link("Privacy Policy", destination: URL(string: "https://makoto808.github.io/waterudrinking-support/privacy")!)
            Link("Terms of Use (EULA)", destination: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
                .padding(.top, 4)
        }
        .font(.custom("ArialRoundedMTBold", size: footnoteSize))
        .foregroundColor(.secondary)
        .background(Color("AppBackgroundColor"))
    }
}

#Preview {
    PurchaseLegalSection()
}
