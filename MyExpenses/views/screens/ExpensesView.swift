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

    func handleDoneItem(itemId: UUID) {
        if let row = expenses.items.firstIndex(where: {$0.id == itemId}) {
            expenses.items[row].isDone = !expenses.items[row].isDone
        }
    }
    
    func moveItems(from source: IndexSet, to destination: Int) {
        expenses.items.move(fromOffsets: source, toOffset: destination)
    }
    
    func removeItems(at offsets: IndexSet, in inputArray: [ExpenseItem]) {
        var objectsToDelete = IndexSet()
        
        for offset in offsets {
            let item = inputArray[offset]
            
            if let index = expenses.items.firstIndex(of: item) {
                objectsToDelete.insert(index)
            }
        }
        
        expenses.items.remove(atOffsets: objectsToDelete)
    }
    
    func removeFromExpenses(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.items)
    }

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
                    ExpenseSection(title: "Transactions", expenses: expenses.items, deleteItems: removeFromExpenses, moveItems: moveItems,
                                   handleDoneItem: handleDoneItem, moveItemsDisable: false, deleteItemsDisable: false)
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
