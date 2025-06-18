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
                        
                        Text("Organic Water").fontCustomDrinkViewTitle()
                        
                        Text("100% Rate of Hydration").fontCustomDrinkViewSubtitle()
                    }
                }
            }
            
            Section {
                HStack {
                    Image("waterBottle").CDVresize()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text("Mineral Water").fontCustomDrinkViewTitle()
                        
                        Text("100% Rate of Hydration").fontCustomDrinkViewSubtitle()
                    }
                }
            }
            
            Section {
                HStack {
                    Image("waterBottle").CDVresize()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text("Sparkling Water").fontCustomDrinkViewTitle()
                        
                        Text("100% Rate of Hydration").fontCustomDrinkViewSubtitle()
                    }
                }
            }
            
            Section {
                HStack {
                    Image("waterBottle").CDVresize()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text("Coconut Water").fontCustomDrinkViewTitle()
                        
                        Text("90% Rate of Hydration").fontCustomDrinkViewSubtitle()
                    }
                }
            }
            
            Section {
                HStack {
                    Image("waterBottle").CDVresize()
                    
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text("Electrolyte Water").fontCustomDrinkViewTitle()
                        
                        Text("100% Rate of Hydration").fontCustomDrinkViewSubtitle()
                    }
                }
            }
        }
    }
}

#Preview {
    CustomDrinkView()
}
