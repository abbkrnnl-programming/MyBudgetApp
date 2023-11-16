//
//  Category.swift
//  PersonalBudgetApp
//
//  Created by Абубакир on 14.11.2023.
//

import Foundation
import SwiftData

@Model
class Category{
    var title: String
    var expenses: [Expense]?
    
    @Relationship(deleteRule: .cascade, inverse: \Expense.category)
    
    init(title: String) {
        self.title = title
    }
}
