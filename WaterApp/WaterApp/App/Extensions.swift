//
//  Extensions.swift
//  WaterApp
//
//  Created by Gregg Abe on 3/26/25.
//

import SwiftUI

extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(limit))
            }
        }
        return self
    }
}

extension Color {
    static let backgroundWhite = Color(red: 0.9373, green: 0.9607, blue: 0.9607)
    
    static let waterBlue = Color(red: 0, green: 0.5, blue: 0.75, opacity: 0.5)
    
    static let lightBlue = Color(red: 0.4275, green: 0.8633, blue: 0.9980, opacity: 0.8)
}

extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}

extension Image {
    func drinkFillResize() -> some View {
        self.resizable()
            .scaledToFit()
            .frame(maxWidth: 500, alignment: .center)
    }
    
    func drinkFillSelectionResize() -> some View {
        self.resizable()
            .scaledToFit()
            .frame(width: 150, height: 110)
    }
    
    func CDVresize() -> some View {
        self.resizable()
            .scaledToFit()
            .frame(height: 70)
            .cornerRadius(4)
    }
    
    func CDVresize2() -> some View {
        self.resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .foregroundColor(.blue)
    }
    
    func customOzButton() -> some View {
        self.resizable()
            .frame(width: 38, height: 38)
    }
    
    func customDrinkButton() -> some View {
        self.resizable()
            .frame(width: 40, height: 40)
    }
    
    func calendarGoalMetImage(backgroundColor: Color) -> some View {
        self.resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .padding(7.5)
            .background(backgroundColor)
            .clipShape(Circle())
    }
    
    func calendarDrinkRowImage() -> some View {
        self.resizable()
            .frame(width: 60, height: 60)
    }
    
    func gearIconResize() -> some View {
        self.resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 38, height: 38)
            .padding(.horizontal, 8)
            .padding(.top, 20)
    }
    
    func calendarIconResize() -> some View {
        self.resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 33, height: 33)
            .padding(.horizontal, 8)
            .padding(.top, 20)
    }
    
    func backButton1() -> some View {
        self.font(.system(size: 20, weight: .heavy))
            .symbolRenderingMode(.hierarchical)
            .foregroundColor(Color.waterBlue)
            .padding(.horizontal, 8)
            .padding(.top, 6)
    }
    
    func plusButton1() -> some View {
        self.font(.system(size: 25, weight: .heavy))
            .symbolRenderingMode(.hierarchical)
            .foregroundColor(Color.waterBlue)
            .padding(.horizontal, 8)
            .padding(.top, 6)
    }
}

extension View {
    func drinkFilllViewButtonStyle(maxWidth: CGFloat = .infinity) -> some View {
        self.buttonBorderShape(.capsule)
            .buttonStyle(.borderedProminent)
            .font(.custom("ArialRoundedMTBold", size: 25))
            .frame(maxWidth: 170)
            .lineLimit(1)
            .allowsTightening(true)
            .minimumScaleFactor(0.30)
            .textCase(.uppercase)
    }
    
    func buttonTrash(maxWidth: CGFloat = .infinity) -> some View {
        self.foregroundColor(.red)
            .buttonStyle(.plain)
            .padding(25)
    }
    
    func buttonCapsule(maxWidth: CGFloat = .infinity) -> some View {
        self.buttonBorderShape(.capsule)
            .buttonStyle(.borderedProminent)
    }
    
    func button1(maxWidth: CGFloat = .infinity) -> some View {
        self.buttonBorderShape(.capsule)
            .buttonStyle(.borderedProminent)
            .font(.custom("ArialRoundedMTBold", size: 20))
    }
    
    func button2(maxWidth: CGFloat = .infinity) -> some View {
        self.buttonBorderShape(.capsule)
            .buttonStyle(.borderedProminent)
            .font(.custom("ArialRoundedMTBold", size: 25))
            .textCase(.uppercase)
    }
    
    func button3(maxWidth: CGFloat = .infinity) -> some View {
        self.buttonBorderShape(.capsule)
            .buttonStyle(.borderedProminent)
            .font(.custom("ArialRoundedMTBold", size: 10))
            .textCase(.uppercase)
    }
}

extension View {
    func goalViewWave(offset: Binding<Angle>, percent: Double = 3.9 / 8.0) -> some View {
        WaveMotion(offset: offset.wrappedValue, percent: percent)
            .fill(Color(red: 0, green: 0.5, blue: 0.75, opacity: 0.5))
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.linear(duration: 3.5).repeatForever(autoreverses: false)) {
                    offset.wrappedValue = Angle(degrees: 360)
                }
            }
    }
}

extension View {
    func backChevronButton(using drinkListVM: DrinkListVM) -> some View {
        self
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        drinkListVM.navPath.removeLast()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .backButton1()
                    }
                }
            }
    }
    
    func plusButton(action: @escaping () -> Void) -> some View {
            self.toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        action()
                    } label: {
                        Image(systemName: "plus")
                            .plusButton1()
                    }
                }
            }
        }
}
