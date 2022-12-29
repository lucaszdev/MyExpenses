//
//  AddView.swift
//  iExpense
//
//  Created by Lucas Lima on 24/12/22.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    @AppStorage("SelectedCategory") var categorySelected = "tshirt"
    
    @State private var name = ""
    @State private var type = "Fixed"
    @State private var dateNow = Date.now
    @State private var amount = 0.0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlertRequiredField = false
    
    let types = ["Fixed", "Variable"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Expense name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                NavigationLink {
                    selectCategoryView()
                } label: {
                    HStack {
                        Text("Selected category:")
                        Image(systemName: categorySelected)
                            .foregroundColor(.accentColor)
                    }
                }
                
                TextField("Amount", value: $amount, format: .localCurrency)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    if name.isEmpty {
                        alertTitle = "Error!"
                        alertMessage = "Expense name can't be empty"
                        return showAlertRequiredField = true
                    } else if amount == 0.0 {
                        alertTitle = "Error!"
                        alertMessage = "Amount can't be 0"
                        return showAlertRequiredField = true
                    }
                    
                    let item = ExpenseItem(name: name, type: type, data: dateNow, amount: amount, isDone: false, category: categorySelected)
                    
                    expenses.items.append(item)
                    dismiss()
                }
            }
            .alert(alertTitle, isPresented: $showAlertRequiredField) {
                Button("Ok") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
