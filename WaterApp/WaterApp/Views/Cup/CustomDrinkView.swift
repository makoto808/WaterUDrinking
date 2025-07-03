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
                        
                        Text("Organic Water").fontSmallTitle()
                        
                        Text("100% Rate of Hydration").fontSmallTitle2()
                    }
                }
            }
            
            Section {
                HStack {
                    Image("waterBottle").CDVresize()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text("Mineral Water").fontSmallTitle()
                        
                        Text("100% Rate of Hydration").fontSmallTitle2()
                    }
                }
            }
            
            Section {
                HStack {
                    Image("waterBottle").CDVresize()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text("Sparkling Water").fontSmallTitle()
                        
                        Text("100% Rate of Hydration").fontSmallTitle2()
                    }
                }
            }
            
            Section {
                HStack {
                    Image("waterBottle").CDVresize()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text("Coconut Water").fontSmallTitle()
                        
                        Text("90% Rate of Hydration").fontSmallTitle2()
                    }
                }
            }
            
            Section {
                HStack {
                    Image("waterBottle").CDVresize()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text("Electrolyte Water").fontSmallTitle()
                        
                        Text("100% Rate of Hydration").fontSmallTitle2()
                    }
                }
            }
        }
    }
}

#Preview {
    CustomDrinkView()
}
