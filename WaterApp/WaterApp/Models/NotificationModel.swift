//
//  NotificationModel.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/6/25.
//

import Foundation
import SwiftUI

struct NotificationModel: Identifiable, Equatable {
    let id = UUID()
    let time: Date
    let label: String
}
