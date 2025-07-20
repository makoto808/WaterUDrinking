//
//  LightDarkModeView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/19/25.
//

import SwiftUI

struct LightDarkModeView: View {
    @Environment(DrinkListVM.self) private var drinkListVM

    @AppStorage("selectedAppearance") private var selectedAppearance: String = AppColorScheme.system.rawValue

    var body: some View {
        let resolvedColorScheme = AppColorScheme(rawValue: selectedAppearance)?.colorScheme

        return ZStack {
            Color("AppBackgroundColor")
                .ignoresSafeArea()
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.35), value: selectedAppearance)

            VStack(spacing: 20) {
                ForEach(AppColorScheme.allCases, id: \.self) { mode in
                    Button {
                        selectedAppearance = mode.rawValue
                    } label: {
                        HStack {
                            Text(mode.displayName)
                                .fontSubtitle()
                                .foregroundColor(.primary)
                            Spacer()
                            if selectedAppearance == mode.rawValue {
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.blue)
                                    .fontWeight(.heavy)
                            }
                        }
                        .padding()
                        .background(Color("PurchaseRowBackground"))
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 20)
                Spacer()
            }
            .padding(.top, 30)
            .navigationBarBackButtonHidden(true)
            .backChevronButton(using: drinkListVM)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Water Theme")
                        .fontBarLabel()
                }
            }
        }
        .applyColorSchemeIfNeeded(resolvedColorScheme)
    }
}

#Preview {
    LightDarkModeView()
        .environment(DrinkListVM())
}
