//
//  ExpensesView.swift
//  PersonalBudgetApp
//
//  Created by Абубакир on 13.11.2023.
//

import SwiftData
import SwiftUI

struct ExpensesView: View {
    @Environment(\.modelContext) var context
    @Query(sort: \Expense.date, order: .reverse, animation: .snappy) var expenses: [Expense] = []
    
    @State var showSheet: Bool = false
    @State private var groupedExpenses: [GroupedExpenses] = []
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(groupedExpenses.indices, id: \.self) { index in
                    Section(header: Text(groupedExpenses[index].groupTitle)) {
                        ForEach(groupedExpenses[index].expenses) { expense in
                            ExpenseCellView(expense: expense)
                            .onAppear(){
                                print(expense.amount)
                            }
                        }
                        .onDelete { indices in
                            // Handle deletion here
                            let deletedExpenses = indices.map { groupedExpenses[index].expenses[$0] }
                            for expense in deletedExpenses {
                                context.delete(expense)
                            }
                            // Update the groupedExpenses array after deletion
                            groupedExpenses[index].expenses.remove(atOffsets: indices)
                        }
                    }
                }
            }
            .navigationTitle("Expenses")
            .toolbar{
                if !expenses.isEmpty{
                    Button {
                        showSheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundStyle(.blue)
                    }
                }
            }
            .overlay{
                if expenses.isEmpty{
                    ContentUnavailableView(label: {
                        Label("No Expenses", systemImage: "tray.fill")
                    }, description: {
                        Text("Add expenses to see them in the list.")
                    }, actions: {
                        Button("Add Expense") {
                            showSheet = true
                        }
                    })
                    .offset(y: -40)
                }
            }
            .onChange(of: expenses, { oldValue, newValue in
                updateGroupedExpenses(expenses: newValue)
            })
            .sheet(isPresented: $showSheet, content: {
                AddExpenseView()
            })
        }
        .onAppear{
            updateGroupedExpenses(expenses: expenses)
        }
    }
    
    func updateGroupedExpenses(expenses: [Expense]){
        Task.detached(priority: .high) {
            let groupedDict = Dictionary(grouping: expenses) { expense in
                let dateComponents = Calendar.current.dateComponents(
                    [.day, .month, .year], from: expense.date)
                
                return dateComponents
            }
            
            //Sorting dictionary in descending order
            let sortedDict = groupedDict.sorted{
                let calendar = Calendar.current
                let date1 = calendar.date(from: $0.key) ?? .init()
                let date2 = calendar.date(from: $1.key) ?? .init()
                
                return calendar.compare(date1, to: date2, toGranularity: .day) == .orderedDescending
            }
            
            //Adding to the GrouppedExpenses Array
            //UI must be updated on main thread
            await MainActor.run{
                groupedExpenses = sortedDict.compactMap({ dict in
                    let date = Calendar.current.date(from: dict.key) ?? .init()
                    return .init(date: date, expenses: dict.value)
                })
            }
        }
    }
}

#Preview {
    ExpensesView()
}
