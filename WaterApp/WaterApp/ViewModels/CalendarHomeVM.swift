//
//  CalendarHomeVM.swift
//  WaterApp
//
//  Created by Ryan Kanno on 4/19/25.
//

import Foundation
import Observation
import SwiftData

@Observable final class CalendarHomeVM {
    private var modelContext: ModelContext?
    
    func setModelContext(_ modelContext: ModelContext) {
        self.modelContext = modelContext
        self.modelContext!.autosaveEnabled = true
    }
}
