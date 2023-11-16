//
//  Expense.swift
//  PersonalBudgetApp
//
//  Created by Абубакир on 13.11.2023.
//

import Foundation
import SwiftData

@Model
class Expense {
    var title: String
    var subTitle: String
    var amount: Double
    var date: Date
    var category: Category?
    
    init(title: String, subTitle: String, amount: Double, date: Date, category: Category) {
        self.title = title
        self.subTitle = subTitle
        self.amount = amount
        self.date = date
        self.category = category
    }
}
