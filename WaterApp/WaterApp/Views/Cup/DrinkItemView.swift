//
//  DrinkItemView.swift
//  WaterApp
//
//  Created by Gregg Abe on 4/2/25.
//

import SwiftUI

struct DrinkItemView: View {
    
    @State var items: [DrinkItem] = [
        DrinkItem(name: "Water", img: "waterBottle"),
        DrinkItem(name: "Tea", img: "tea"),
        DrinkItem(name: "Coffee", img: "coffee"),
        DrinkItem(name: "Soda", img: "soda"),
        DrinkItem(name: "Juice", img: "juice"),
        DrinkItem(name: "Milk", img: "milk"),
        DrinkItem(name: "Energy Drink", img: "energyDrink"),
        DrinkItem(name: "Beer", img: "beer")
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                List($items) { $item in
                    Text(item.name)
                }
            }
        }
    }
}
    
    #Preview {
        DrinkItemView()
    }
