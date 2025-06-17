//
//  CustomOzView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/30/25.
//

import SwiftUI

struct CustomOzView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var text: String = ""
    
    @FocusState private var focus: Bool
    @FocusState private var keyboardFocused: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack(spacing: 4) {
                TextField("", text: self.$text.max(4))
                    .font(.custom("ArialRoundedMTBold", size: 40))
                    .focused($keyboardFocused)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
                    .frame(width: 100)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            keyboardFocused = true
                        }
                    }
                
                Text("oz")
                    .foregroundColor(.primary)
                    .font(.custom("ArialRoundedMTBold", size: 40))
            }
            .padding(8)
            
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "x.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                
                Spacer()
                
                Button("+ Custom Amount ", systemImage: "lock") {
                }
                .buttonBorderShape(.capsule)
                .buttonStyle(.borderedProminent)
                .font(.custom("ArialRoundedMTBold", size: 20))
            }
            .padding(50)
            .onAppear {
                focus = true
            }
        }
    }
}


#Preview {
    CustomOzView()
}
