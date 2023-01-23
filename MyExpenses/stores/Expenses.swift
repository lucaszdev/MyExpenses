//
//  Expenses.swift
//  iExpense
//
//  Created by Lucas Lima on 24/12/22.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    @Published var salary = 1200.0 {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(salary) {
                UserDefaults.standard.set(encoded, forKey: "Salary")
            }
        }
    }
    
    @Published var showingAddExpense = false
    @Published var showingChangeSalary = false
    
    var fixedItems: [ExpenseItem] {
        items.filter { $0.type == "Fixed" }
    }
    
    var variableItems: [ExpenseItem] {
        items.filter { $0.type == "Variable" }
    }
    
    var totalVariableAmount: Double {
        var total = 0.0
        
        for item in variableItems {
            total += item.amount
        }
        
        return total
    }
    
    var totalFixedAmount: Double {
        var total = 0.0
        
        for item in fixedItems {
            total += item.amount
        }
        
        return total
    }
    
    var totalAmount: Double {
        var total = 0.0
        
        for item in items {
            total += item.amount
        }
        
        return total
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
            }
        } else {
            items = []
        }
        
        if let salaryValue = UserDefaults.standard.data(forKey: "Salary") {
            if let decodedSalary = try? JSONDecoder().decode(Double.self, from: salaryValue) {
                salary = decodedSalary
            }
        } else {
            salary = 1200.0
        }
    }
}
