//
//  SettingsNavRow.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/10/25.
//

import SwiftUI

struct SettingsNavRow: View {
    let title: String
    let icon: String?
    let action: () -> Void

    init(title: String, icon: String? = nil, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack {
                if let icon {
                    Image(systemName: icon)
                        .foregroundColor(.blue)
                        .frame(width: 24)
                }

                Text(title)
                    .fontSmallTitleSetting()
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.waterBlue)
                    .fontWeight(.heavy)
            }
            .contentShape(Rectangle())
            .padding(.vertical, 12)
        }
        .buttonStyle(.plain)
    }
}
