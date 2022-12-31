//
//  FuncHelper.swift
//  MyExpenses
//
//  Created by Lucas Lima on 30/12/22.
//

import Foundation

class FuncHelper {
    @Published var expenses: Expenses
    
    init(expenses: Expenses) {
        self.expenses = expenses
    }
    
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
    
    func removeFixedItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.fixedItems)
    }
    
    func removeVariableItems(at offsets: IndexSet) {
        removeItems(at: offsets, in: expenses.variableItems)
    }
}

