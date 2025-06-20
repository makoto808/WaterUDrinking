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

    let item: DrinkItem

    var body: some View {

        @Bindable var vm = vm
        VStack {
            Spacer()
            Spacer()

            Text("\(vm.value.formatted()) oz")
                .font(.custom("ArialRoundedMTBold", size: 45))

            // TODO: adds another layer for fill effect with Slider()
            Image(item.img)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 500, alignment: .center)
                .sheet(isPresented: $vm.showingCustomDrinkView) {
                    CustomDrinkView()
                }

            Slider(value: $vm.value, in: 0...20, step: 0.1)
                .padding(30)

            HStack {
                Button {
                    // TODO: select similar drinks within of different sizes
                    vm.showingCustomDrinkView.toggle()
                } label: {
                    Image(item.img)
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                
                Spacer()

                Button("+ \(item.name) ") {
                    if let newItem = vm.parseNewCachedItem(for: item) {
                        modelContext.insert(newItem)
                        do {
                            try modelContext.save()
                        } catch {
                            print("Failed to save: \(error.localizedDescription)")
                        }
                    }
                    vm.navPath.removeLast()
                }
                .drinkFilllViewButtonStyle()
                .alert("You didn't drink anything!", isPresented: $vm.showAlert) {
                    Button("Dismiss") {}
                }

                Spacer()

                Button {
                    vm.showingCustomOzView.toggle()
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                .sheet(isPresented: $vm.showingCustomOzView) {
                    CustomOzView()
                        .presentationDetents([.fraction(2/6)], selection: $vm.settingsDetent)
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
