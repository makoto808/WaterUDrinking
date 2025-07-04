//
//  CustomOzView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/30/25.
//

import SwiftUI

struct CustomOzView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @Environment(DrinkListVM.self) private var drinkListVM
    
    @State private var text: String = ""
    
    @FocusState private var focus: Bool
    @FocusState private var keyboardFocused: Bool
    
    let item: DrinkItem
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                TextField("", text: self.$text.max(4))
                    .fontCustomOzViewTextField()
                    .focused($keyboardFocused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            keyboardFocused = true
                        }
                    }

                Text(" oz")
                    .fontOzLabel()
            }
            .padding(8)
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "x.circle")
                        .customOzButton()
                }

                Spacer()

                CustomOzButton(text: $text, item: item)
                    .button1()
            }
            .padding(50)
            .onAppear {
                focus = true
            }
        }
    }
}

#Preview {
    CustomOzView(item: DrinkItem(name: "Water", img: "waterBottle", volume: 8))
        .environment(DrinkListVM())
}
