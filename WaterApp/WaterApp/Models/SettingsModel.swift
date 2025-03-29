//
//  SettingsModel.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/27/25.
//

import SwiftUI

struct SettingsModel: Identifiable, Hashable {
    var name: String
    var icon: String
    let id = UUID()
}

struct SettingsRow: View {
    let setting: SettingsModel

    var body: some View {
        HStack {
            Text(setting.icon)
            
            Text(setting.name)
                .font(.title)
            
            Spacer()
        }
    }
}

//#Preview {
//    SettingsModel(name: "Cocktail List", icon: "🍹")
//}
