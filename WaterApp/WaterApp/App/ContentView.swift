//
//  ContentView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/22/25.
//

import SwiftUI

struct ContentView: View {
    //    @StateObject private var vm = HomeView() ???
    
    var body: some View {
        NavigationStack {
            Text("You need to drink more water!")
            NavigationLink(destination: HomeView()) {
                Text("Enter")
            }
        }
    }
}

#Preview {
    ContentView()
}
