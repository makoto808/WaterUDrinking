//
//  DrinkSelectionView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/23/25.
//

import SwiftUI

struct DrinkSelectionView: View {
    @Environment(DrinkListVM.self) private var vm
    @Environment(\.modelContext) private var modelContext
    @State private var scale = 1.0
    
    var body: some View {
        @Bindable var vm = vm
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: -20) {
                    ForEach($vm.items) { $drink in
                        VStack(spacing: 10) {
                            Button {
                                vm.navPath.append(.drinkFillView(drink))
                            } label: {
                                Image(drink.img)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 110)
                            }
                            
                            Text(drink.name)
                                .foregroundStyle(.gray)
                                .font(.custom("ArialRoundedMTBold", size: 16))
                        }
                    }
                    .scrollTransition { content, phase in
                        content
                            .opacity(phase.isIdentity ? 1.0 : 0.0)
                            .offset(y: phase.isIdentity ? 0 : 50)
                    }
                }
            }
        }
        .background(Color.backgroundWhite)
    }
}


// TODO: add in button after 8th drink for other options of drinks. will not replace anything in first 8

#Preview {
    DrinkSelectionView()
}
