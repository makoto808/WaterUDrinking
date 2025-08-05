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
                Text("⚠️ Disclaimer")
                    .fontDisclaimerHeader()

                Text("""
        This app is intended for general wellness and hydration tracking purposes only. It does **not** diagnose, treat, cure, or prevent any medical condition. Please consult with a licensed medical professional for personalized health advice.
        """)
                .fontDisclaimerText()
                
                Divider()
                
                Text("📚 Research Reference & Attribution")
                    .fontDisclaimerHeader()
                
                Text("""
        The hydration insights in this app are informed in part by publicly available data from the **U.S. National Library of Medicine (NLM)**, a division of the National Institutes of Health. In particular, hydration efficiency estimates are influenced by the concept of the **Beverage Hydration Index (BHI)**, which compares how different beverages affect fluid retention in the body. The hydration rates should be considered as approximations rather than precise values.
        """)
                .fontDisclaimerText()
                
                Text("**Source:** Courtesy of the National Library of Medicine\n[https://www.nlm.nih.gov/](https://www.nlm.nih.gov/)")
                    .fontDisclaimerText()

                Text("""
        As a work produced by the U.S. government, this material is in the public domain and may be used without special permission. We acknowledge the NLM as the original source and make no claims to their endorsement or affiliation.
        """)
                .fontDisclaimerText()

                Divider()

                Text("🧪 Additional Academic Source")
                    .fontDisclaimerHeader()

                Text("""
        Mindy Millard-Stafford, Teresa K. Snow, Michael L. Jones, HyunGyu Suh (Edited by Yugo Shibagaki). © 2021 by the authors. This article is an open access publication distributed under the terms of the **Creative Commons Attribution 4.0 International License (CC BY 4.0)**.  
        [https://creativecommons.org/licenses/by/4.0/](https://creativecommons.org/licenses/by/4.0/)  
        PMCID: PMC8465972 PMID: 34578811

        We include this research as a supporting academic reference. Views expressed are those of the authors and do not necessarily represent those of the licensee or publisher.
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
