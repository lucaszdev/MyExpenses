//
//  Categories.swift
//  MyExpenses
//
//  Created by Lucas Lima on 26/12/22.
//

import SwiftUI

struct TypesView: View {
    @ObservedObject var expenses: Expenses
    
    var body: some View {
        NavigationStack {
            List {
                if !expenses.items.isEmpty {
                    BarChart(expenses: expenses)
                }
                
                if expenses.fixedItems.isEmpty {
                    Section("Fixed") {
                        Text("No fixed items")
                    }
                } else {
                    ExpenseSection(
                        title: "Fixed",
                        expenses: expenses.items,
                        deleteItems: FuncHelper(expenses: expenses).removeFixedItems,
                        moveItems: FuncHelper(expenses: expenses).moveItems,
                        handleDoneItem: FuncHelper(expenses: expenses).handleDoneItem,
                        moveItemsDisable: true,
                        deleteItemsDisable: true
                    )
                }
                
                if expenses.variableItems.isEmpty {
                    Section("Variable") {
                        Text("No variable items")
                    }
                } else {
                    ExpenseSection(
                        title: "Variable",
                        expenses: expenses.items,
                        deleteItems: FuncHelper(expenses: expenses).removeVariableItems,
                        moveItems: FuncHelper(expenses: expenses).moveItems,
                        handleDoneItem: FuncHelper(expenses: expenses).handleDoneItem,
                        moveItemsDisable: true,
                        deleteItemsDisable: true
                    )
                }
            }
            .navigationTitle("Types")
        }
        
    }
}

struct Types_Previews: PreviewProvider {
    static var previews: some View {
        TypesView(expenses: Expenses())
    }
}
