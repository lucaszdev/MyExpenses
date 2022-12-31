//
//  ExpensesView.swift
//  MyExpenses
//
//  Created by Lucas Lima on 26/12/22.
//

import SwiftUI

struct ExpensesView: View {
    @Environment(\.editMode) var editMode
    @ObservedObject var expenses: Expenses
    
    @State private var showingAddExpense = false
    @State private var showingChangeSalary = false
    @AppStorage("Salary") var salary: Double = 5000.0
    @AppStorage("ThemeDarkMode") var theme = false

    var body: some View {
        NavigationStack {
            List {
                Section("Your salary") {
                    HStack {
                        Text(salary, format: .localCurrency)
                            .font(.largeTitle.bold())
                            .foregroundColor(.green)
                        
                        Spacer()
                        
                        Text("Change")
                            .foregroundColor(Color.accentColor)
                            .onTapGesture {
                                showingChangeSalary = true
                            }
                    }
                }
                
                Section("My expenses") {
                    Text(-expenses.totalAmount, format: .localCurrency)
                        .font(.largeTitle.bold())
                        .foregroundColor(.red)
                }
                
                Section("Remaining balance") {
                    Text(salary - expenses.totalAmount, format: .localCurrency)
                        .font(.largeTitle.bold())
                        .foregroundColor(.green)
                }
                
                if expenses.items.isEmpty {
                    Section("Transactions") {
                        Text("No Transactions")
                    }
                } else {
                    ExpenseSection(
                        title: "Transactions",
                        expenses: expenses.items,
                        deleteItems: FuncHelper(expenses: expenses).removeFromExpenses, moveItems: FuncHelper(expenses: expenses).moveItems,
                                   handleDoneItem: FuncHelper(expenses: expenses).handleDoneItem,
                        moveItemsDisable: false,
                        deleteItemsDisable: false)
                }
            }
            .navigationTitle("Expenses")
            .toolbar {
                if !expenses.items.isEmpty {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddExpense = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
                    .preferredColorScheme(theme ? .dark : .light)
            }
            .sheet(isPresented: $showingChangeSalary) {
                ChangeSalary(salary: $salary)
                    .preferredColorScheme(theme ? .dark : .light)
            }
        }
    }
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView(expenses: Expenses())
    }
}
