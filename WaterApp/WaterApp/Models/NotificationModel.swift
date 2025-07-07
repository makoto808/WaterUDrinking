//
//  NotificationModel.swift
//  WaterApp
//
//  Created by Gregg Abe on 7/6/25.
//

import Foundation
import SwiftData

@Model
class NotificationModel: Identifiable, Equatable {
    @Attribute(.unique) var id: UUID
    var time: Date
    var label: String

    init(id: UUID = UUID(), time: Date, label: String) {
        self.id = id
        self.time = time
        self.label = label
    }

    static func == (lhs: NotificationModel, rhs: NotificationModel) -> Bool {
        lhs.id == rhs.id
    }
}
