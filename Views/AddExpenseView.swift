//
//  AddExpenseView.swift
//  PersonalBudgetApp
//
//  Created by Абубакир on 13.11.2023.
//

import SwiftUI
import SwiftData

struct AddExpenseView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var title: String = ""
    @State private var subTitle: String = ""
    @State private var amount: Double = 1.0
    @State private var date: Date = Date.now
    @Query var categories: [Category] = []
    @State private var selectedCategory: Category = Category(title: "Shopping")
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    var body: some View {
        NavigationStack{
            List{
                Section("Title") {
                    TextField("MacBook Pro M2", text: $title)
                }
                Section("Description") {
                    TextField("Bought in Apple Store", text: $subTitle)
                }
                Section("Amount Spent") {
                    HStack(spacing: 3){
                        Text("€")
                        TextField("0,00", value: $amount, formatter: formatter)
                            .keyboardType(.numberPad)
                    }
                }
                Section("Category") {
                    Picker("Select a Category", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category.title)
                                .tag(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                Section("Date") {
                    DatePicker("\(Date.now)", selection: $date, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                }
            }
            .navigationTitle("New Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save"){
                        let expense = Expense(
                            title: title,
                            subTitle: subTitle,
                            amount: amount,
                            date: date,
                            category: selectedCategory
                        )
                        context.insert(expense)
                        dismiss()
                    }
                    .disabled(SaveButtonDisabled())
                }
            }
        }
    }
    
    func SaveButtonDisabled() -> Bool{
        return title.count < 3 || amount == 0
    }
}

#Preview {
    AddExpenseView()
}
