//
//  ContentView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/22/25.
//

import SwiftUI

struct ContentView: View {
    @State var vm = DrinkListVM()
    
    var body: some View {
        NavigationStack {
            HomeView(item: .constant(DrinkItem(name: "Water", img: "waterBottle", volume: 0.0)))
        }
        .environment(vm)
    }
}

#Preview {
    ContentView()
}
