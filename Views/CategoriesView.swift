//
//  CategoriesView.swift
//  PersonalBudgetApp
//
//  Created by Абубакир on 14.11.2023.
//

import SwiftUI
import SwiftData

struct CategoriesView: View {
    
    @Environment(\.modelContext) var context
    @Query var categories: [Category] = []
    
    @State var showSheet = false
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(categories){ category in
                    DisclosureGroup {
                        let expenses = category.expenses ?? []
                        if !expenses.isEmpty{
                            ForEach(expenses){expense in
                                ExpenseCellView(expense: expense)
                            }
                        } else{
                            ContentUnavailableView{
                                Label("No Expenses", systemImage: "tray.fill")
                            }
                        }
                    } label: {
                        Text(category.title)
                    }
                }
                .onDelete { indices in
                    // Handle deletion of the category and its expenses here
                    for index in indices {
                        let category = categories[index]
                        let expenses = category.expenses ?? []
                        
                        // Delete associated expenses
                        for expense in expenses {
                            context.delete(expense)
                        }
                        
                        // Delete the category
                        context.delete(category)
                    }
                }
            }
            .navigationTitle("Categories")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    if !categories.isEmpty{
                        Button {
                            showSheet = true
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundStyle(.blue)
                        }
                    }
                }
            }
            .overlay{
                if categories.isEmpty{
                    ContentUnavailableView(label: {
                        Label("No Categories", systemImage: "tray.fill")
                    }, description: {
                        Text("Add some vategories to see them in the list.")
                    }, actions: {
                        Button("Add Category") {
                            showSheet = true
                        }
                    })
                    .offset(y: 0)
                }
            }
            .sheet(isPresented: $showSheet) {
                AddCategoryView()
                    .presentationDetents([.height(200)])
                    .presentationCornerRadius(20)
            }
        }
    }
}

#Preview {
    CategoriesView()
}
