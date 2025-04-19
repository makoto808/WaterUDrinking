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
    
    var items: [DrinkItem] = []
    
    func setModelContext(_ modelContext: ModelContext) {
        self.modelContext = modelContext
        self.modelContext!.autosaveEnabled = true
    }
    
    func getCachedItems(for date: Date) {
        do {
            let descriptor = FetchDescriptor<CachedDrinkItem>(
                predicate: #Predicate { $0.date == date },
                sortBy: [SortDescriptor(\.arrayOrderValue)])
            if let cachedItems = try modelContext?.fetch(descriptor) {
                items = cachedItems.map({ DrinkItem($0) })
            }
        } catch {
            print(error)
        }
    }
}
