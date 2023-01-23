//
//  ExpensesView.swift
//  MyExpenses
//
//  Created by Lucas Lima on 26/12/22.
//

import SwiftUI

struct ExpensesView: View {
    @ObservedObject var expenses: Expenses
    
    var body: some View {
        NavigationStack {
            List {
                Section("Your salary") {
                    HStack {
                        Text(expenses.salary, format: .localCurrency)
                            .font(.largeTitle.bold())
                            .foregroundColor(.green)
                        
                        Spacer()
                        
                        Text("Change")
                            .foregroundColor(Color.accentColor)
                            .onTapGesture {
                                expenses.showingChangeSalary = true
                            }
                    }
                }
                
                Section("My expenses") {
                    Text(-expenses.totalAmount, format: .localCurrency)
                        .font(.largeTitle.bold())
                        .foregroundColor(.red)
                }
                
                Section("Remaining balance") {
                    Text(expenses.salary - expenses.totalAmount, format: .localCurrency)
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
                        expenses.showingAddExpense = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $expenses.showingAddExpense) {
                AddView(expenses: expenses)
            }
            .sheet(isPresented: $expenses.showingChangeSalary) {
                ChangeSalary(salary: $expenses.salary)
            }
        }
    }
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView(expenses: Expenses())
    }
}
