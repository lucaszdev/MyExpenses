//
//  Categories.swift
//  MyExpenses
//
//  Created by Lucas Lima on 26/12/22.
//

import SwiftUI

struct TypesView: View {
    @ObservedObject var expenses: Expenses
    
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
    
    func removeFixedItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.fixedItems)
    }
    
    func removeVariableItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.variableItems)
    }
    
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
                    ExpenseSection(title: "Fixed", expenses: expenses.fixedItems, deleteItems: removeFixedItems, moveItems: moveItems, handleDoneItem: handleDoneItem, moveItemsDisable: true, deleteItemsDisable: true)
                }
                
                if expenses.variableItems.isEmpty {
                    Section("Variable") {
                        Text("No variable items")
                    }
                } else {
                    ExpenseSection(title: "Variable", expenses: expenses.variableItems, deleteItems: removeVariableItems, moveItems: moveItems,  handleDoneItem: handleDoneItem, moveItemsDisable: true, deleteItemsDisable: true)
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
