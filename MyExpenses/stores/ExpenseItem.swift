//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Lucas Lima on 24/12/22.
//

import Foundation

struct ExpenseItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let type: String
    let data: Date
    let amount: Double
    var isDone: Bool
    var category: String
}
