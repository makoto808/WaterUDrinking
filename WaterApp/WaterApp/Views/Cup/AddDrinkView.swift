//
//  AddDrinkView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/26/25.
//

import SwiftData
import SwiftUI

struct AddDrinkView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Environment(DrinkListVM.self) private var drinkListVM

    @State private var name = ""
    @State private var selectedImage = "waterBottle" // Or image picker

    var body: some View {
        NavigationStack {
            Form {
                TextField("Drink Name", text: $name)
                Picker("Icon", selection: $selectedImage) {
                    ForEach(["waterBottle", "tea", "coffee", "juice", "soda"], id: \.self) {
                        Text($0)
                    }
                }
            }
            .navigationTitle("New Drink")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newUserDrink = UserArrangedDrinkItem(
                            name: name,
                            img: selectedImage,
                            arrayOrderValue: drinkListVM.items.count
                        )
                        modelContext.insert(newUserDrink)
                        try? modelContext.save()

                        drinkListVM.items.append(
                            DrinkItem(name: name, img: selectedImage, volume: 0)
                        )
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    AddDrinkView()
}
