//
//  ContentView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/22/25.
//

import SwiftUI

struct ContentView: View {
    @State private var vm = DrinkListVM()
    
    var body: some View {
        NavigationStack {
            HomeView()
        }
        .environment(vm)
    }
}

#Preview {
    ContentView()
}
