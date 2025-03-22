//
//  HomeView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/22/25.
//

import SwiftUI

struct HomeView: View {
    @State private var percent = 50.0
    
    var body: some View {
        VStack {
            CupView(percent: Int(self.percent))
            Slider(value: self.$percent, in: 0...100)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CupView(percent: 58)
//    }
//}

#Preview {
    CupView(percent: 50)
}
