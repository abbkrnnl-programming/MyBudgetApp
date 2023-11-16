//
//  AddCategoryView.swift
//  PersonalBudgetApp
//
//  Created by Абубакир on 14.11.2023.
//

import SwiftUI
import SwiftData

struct AddCategoryView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    @State var title: String = ""
    
    var body: some View {
        NavigationStack{
            List{
                Section("Title") {
                    TextField("Shopping", text: $title)
                }
            }
            .navigationTitle("New Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save"){
                        //Save
                        let category = Category(title: title)
                        context.insert(category)
                        try? context.save()
                        dismiss()
                    }
                }
            }
        }
        
    }
}

#Preview {
    AddCategoryView()
}
