//
//  LoadingView.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/16/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView("Loading Products...")
            .progressViewStyle(CircularProgressViewStyle())
            .padding()
    }
}
