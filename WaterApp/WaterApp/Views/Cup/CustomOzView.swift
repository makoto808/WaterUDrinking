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
            
            HStack(spacing: 4) {
                TextField("", text: self.$text.max(4))
                    .fontCustomOzViewTextField()
                    .focused($keyboardFocused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            keyboardFocused = true
                        }
                    }
                
                Text("oz")
                    .fontOzLabel()
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
                    guard let customAmount = Double(text), customAmount > 0 else {
                        drinkListVM.showAlert = true
                        return
                    }

                    if let newItem = drinkListVM.parseNewCachedItem(for: item, volume: customAmount) {
                        modelContext.insert(newItem)
                        do {
                            try modelContext.save()
                            drinkListVM.refreshFromCache(modelContext)
                        } catch {
                            print("Failed to save: \(error.localizedDescription)")
                        }
                    } else {
                        drinkListVM.showAlert = true
                    }
                    text = ""
                    dismiss()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                        drinkListVM.navPath.removeLast()
                    }
                }
                .button1()
            }
            .padding(50)
            .onAppear {
                focus = true
            }
        }
    }
}

//#Preview {
//    CustomOzView()
//}
