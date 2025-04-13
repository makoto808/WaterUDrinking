//
//  DrinkFillView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/29/25.
//

import SwiftUI

struct DrinkFillView: View {
    @Environment(DrinkListVM.self) private var vm
    
    @State private var settingsDetent = PresentationDetent.medium
    @State private var showingCustomOzView = false
    @State private var showingCustomDrinkView = false
    @State private var showAlert = false
    @State private var value = 0.0
    
    let item: DrinkItem
    
    var startOz: Double {
        let total = value + vm.totalOz
        return total
    }
    
    var body: some View {
        @Bindable var vm = vm
        VStack {
            Spacer()
            Spacer()
            
            Text("\(value.formatted()) oz")
                .font(.custom("ArialRoundedMTBold", size: 45))
            
            ZStack{
                Image(item.img)
                    .resizable()
                    .frame(width: 500, height: 500, alignment: .center)
                //TODO: adds another layer for fill effect with Slider()
            }
            .sheet(isPresented: $showingCustomDrinkView) {
                CustomDrinkView()
            }
            
            Slider(value: $value, in: 0...20, step: 0.1)
                .padding(30)
            
            HStack {
                Button {
                    //TODO: select similar drinks within of different sizes
                    showingCustomDrinkView.toggle()
                } label: {
                    Image(item.img)
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                
                Spacer()
                
                Button("+ \(item.name) ") {
                    //TODO: adds value to cup HomeView, return to HomeView
                    if value == 0 {
                        showAlert = true
                    } else {
                        value += value
                        print("\(value)")
//                        vm.navPath.removeAll()
                    }
                }
                .buttonBorderShape(.capsule)
                .buttonStyle(.borderedProminent)
                .font(.custom("ArialRoundedMTBold", size: 25))
                .textCase(.uppercase)
                .alert("You didn't drink anything!", isPresented: $showAlert) {
                    Button("Dismiss") {}
                }
                
                Spacer()
                
                Button {
                    showingCustomOzView.toggle()
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                .sheet(isPresented: $showingCustomOzView) {
                    CustomOzView()
                        .presentationDetents([.fraction(2/6)], selection: $settingsDetent)
                }
            }
            .padding(25)
            
            Spacer()
        }
        .background(Color.backgroundWhite)
        .onAppear {
            vm.setSelectedItemIndex(for: item)
        }
        .onDisappear {
            vm.selectedItemIndex = nil
        }
    }
}

#Preview {
    DrinkFillView(item: DrinkItem(name: "Water", img: "waterBottle", volume: 0.0))
}
