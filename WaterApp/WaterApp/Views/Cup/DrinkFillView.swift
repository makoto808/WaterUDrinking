//
//  DrinkFillView.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/29/25.
//

import SwiftUI
import SwiftData

struct DrinkFillView: View {
    @Environment(\.modelContext) private var modelContext

    @Environment(DrinkListVM.self) private var vm
    
    @State private var settingsDetent = PresentationDetent.medium
    @State private var showingCustomOzView = false
    @State private var showingCustomDrinkView = false
    @State private var showAlert = false
    @State private var value = 0.0
    
    let item: DrinkItem
    
    var body: some View {
        @Bindable var vm = vm
        VStack {
            Spacer()
            Spacer()
            
            Text("\(value.formatted()) oz")
                .font(.custom("ArialRoundedMTBold", size: 45))
            
            Image(item.img) //TODO: adds another layer for fill effect with Slider()
                .resizable()
                .frame(width: 500, height: 500, alignment: .center)
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
                    guard let i = vm.selectedItemIndex else { return }
                    if value == 0 {
                        showAlert = true
                    } else {
                        vm.items[i].volume += value
                    }
                    let newItem = CachedDrinkItem(
                        date: Date(),
                        name: item.name,
                        img: item.img,
                        volume: value,
                        arrayOrderValue: 0 // Or however you want to order
                    )
                    
                    modelContext.insert(newItem)
                    
                    do {
                        try modelContext.save()
                    } catch {
                        print("Failed to save: \(error.localizedDescription)")
                    }

                    vm.navPath.removeLast()
                
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
            .padding(20)
            
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
    let mockItem = DrinkItem(name: "Water", img: "waterBottle", volume: 8.0)
    
    let mockVM = DrinkListVM()
    mockVM.items = [mockItem] // Include the item so `setSelectedItemIndex` works
    
    return DrinkFillView(item: mockItem)
        .environment(mockVM)
}

