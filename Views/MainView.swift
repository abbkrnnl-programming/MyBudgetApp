//
//  ContentView.swift
//  PersonalBudgetApp
//
//  Created by Абубакир on 13.11.2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            ExpensesView()
                .tabItem {
                    Label("Expenses", systemImage: "creditcard.fill")
                }
            
            CategoriesView()
                .tabItem {
                    Label("Categories", systemImage: "list.clipboard.fill")
                }
        }
    }
}

#Preview {
    MainView()
}
