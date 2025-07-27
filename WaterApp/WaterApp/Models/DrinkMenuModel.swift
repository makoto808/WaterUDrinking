//
//  DrinkMenuModel.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/26/25.
//

import SwiftUI
import SwiftData

struct DrinkMenuModel: View {
    let drink: DrinkItem
    var isBeingDragged: Bool = false

    var onDragStart: (() -> Void)? = nil
    var onDragEnd: (() -> Void)? = nil

    var body: some View {
        Button(action: {
            // Your button action here
        }) {
            HStack {
                Image(drink.img)
                    .resizable()
                    .frame(width: 45, height: 45)
                    .padding(.leading, 15)
                    .padding(.trailing, 10)

                Text(drink.name)
                    .fontSmallTitle()

                Spacer()

                Image(systemName: "line.3.horizontal")
                    .foregroundStyle(.secondary)
                    .padding(.trailing, 15)
                    .contentShape(Rectangle()) // Make tappable area rectangular
                    .padding(10)              // Expand tappable area around the icon by 10 points
                    .onDrag {
                        onDragStart?()
                        return NSItemProvider(object: drink.id as NSString)
                    } preview: {
                        EmptyView()
                    }
                    .gesture(
                        DragGesture(minimumDistance: 5)
                            .onChanged { _ in
                                onDragStart?()
                            }
                            .onEnded { _ in
                                onDragEnd?()
                            }
                    )

            }
            .contentShape(Rectangle())
            .frame(height: 65)
            .background(Color.black.opacity(0.07))
            .cornerRadius(13)
            .padding(.vertical, 3)
            .padding(.horizontal, 20)
            .animation(.easeInOut(duration: 0.15), value: isBeingDragged)
        }
        .buttonStyle(.plain)
    }
}
