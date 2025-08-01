//
//  Disclaimer.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/31/25.
//

import SwiftUI

struct Disclaimer: View {
    @Environment(DrinkListVM.self) private var drinkListVM

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("📚 Research Reference & Attribution")
                    .fontDisclaimerHeader()
                
                Text("""
The hydration insights in this app are informed in part by publicly available data from the **U.S. National Library of Medicine (NLM)**, a division of the National Institutes of Health. In particular, hydration efficiency estimates are influenced by the concept of the **Beverage Hydration Index (BHI)**, which compares how different beverages affect fluid retention in the body.
""")
                .fontDisclaimerText()
                
                Text("**Source:** Courtesy of the National Library of Medicine\n[https://www.nlm.nih.gov/](https://www.nlm.nih.gov/)")
                    .fontDisclaimerText()

                Text("""
As a work produced by the U.S. government, this material is in the public domain and may be used without special permission. We acknowledge the NLM as the original source and make no claims to their endorsement or affiliation.
""")
                .fontDisclaimerText()
                
                Divider()
                
                Text("⚠️ Disclaimer")
                    .font(.title2)
                    .bold()

                Text("""
This app is intended for general wellness and hydration tracking purposes only. It does **not** diagnose, treat, cure, or prevent any medical condition. Please consult with a licensed medical professional for personalized health advice.
""")
                .fontDisclaimerText()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color("AppBackgroundColor"))
        .backChevronButton(using: drinkListVM)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("")
                    .fontDisclaimerHeader()
            }
        }
    }
}

//#Preview {
//    Disclaimer()
//}
