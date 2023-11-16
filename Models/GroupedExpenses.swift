//
//  GroupedExpenses.swift
//  PersonalBudgetApp
//
//  Created by Абубакир on 14.11.2023.
//

import Foundation
import SwiftUI

struct GroupedExpenses: Identifiable{
    var id: UUID = .init()
    var date: Date
    var expenses: [Expense]
    
    //Group Title
    var groupTitle: String{
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date){
                    return "Today"
        } else if calendar.isDateInYesterday(date){
            return "Yesterday"
        }
        return date.formatted(date: .abbreviated, time: .omitted)
    }
}
