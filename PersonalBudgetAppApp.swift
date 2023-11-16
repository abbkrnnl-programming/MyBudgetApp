//
//  PersonalBudgetAppApp.swift
//  PersonalBudgetApp
//
//  Created by Абубакир on 13.11.2023.
//

import SwiftUI
import SwiftData

@main
struct PersonalBudgetAppApp: App {
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: [Expense.self, Category.self])
    }
}
