//
//  CustomDrinkView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/31/25.
//

import SwiftUI

struct CustomDrinkView: View {
    
    var body: some View {
        List {
            Section {
                HStack {
                    Image("waterBottle").CDVresize()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text("Organic Water").fontCDVTitle()
                        
                        Text("100% Rate of Hydration").fontCDVSubtitle()
                    }
                }
            }
            
            Section {
                HStack {
                    Image("waterBottle").CDVresize()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text("Mineral Water").fontCDVTitle()
                        
                        Text("100% Rate of Hydration").fontCDVSubtitle()
                    }
                }
            }
            
            Section {
                HStack {
                    Image("waterBottle").CDVresize()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text("Sparkling Water").fontCDVTitle()
                        
                        Text("100% Rate of Hydration").fontCDVSubtitle()
                    }
                }
            }
            
            Section {
                HStack {
                    Image("waterBottle").CDVresize()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text("Coconut Water").fontCDVTitle()
                        
                        Text("90% Rate of Hydration").fontCDVSubtitle()
                    }
                }
            }
            
            Section {
                HStack {
                    Image("waterBottle").CDVresize()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text("Electrolyte Water").fontCDVTitle()
                        
                        Text("100% Rate of Hydration").fontCDVSubtitle()
                    }
                }
            }
        }
    }
}




#Preview {
    CustomDrinkView()
}
