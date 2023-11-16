//
//  ExpenseCellView.swift
//  PersonalBudgetApp
//
//  Created by Абубакир on 13.11.2023.
//

import SwiftUI

struct ExpenseCellView: View {
    let expense: Expense
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(expense.title)
                Text("\(expense.subTitle)")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Text("€ \(expense.amount, specifier: "%.2f")")
                .font(.headline)
        }
    }
}

#Preview {
    ExpenseCellView(expense: Expense(title: "", subTitle: "", amount: 0.0, date: .now, category: Category(title: "")))
}
