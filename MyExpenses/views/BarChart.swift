//
//  BarChart.swift
//  MyExpenses
//
//  Created by Lucas Lima on 26/12/22.
//

import SwiftUI
import Charts

struct BarChart: View {
    @ObservedObject var expenses: Expenses
    
    struct Category: Identifiable {
        var id = UUID()
        let category: String
        let amount: Double
    }
    
    var data: [Category] {
        get {
            return [
                Category(category: "Fixed", amount: expenses.totalFixedAmount),
                Category(category: "Variable", amount: expenses.totalVariableAmount)
            ]
        }
    }
    
    let weekdays = ["Jan", "Fev"]
    let steps = [40, 60]
    
    var body: some View {
        VStack {
            GroupBox("Spending") {
                Chart(data) {
                    BarMark(
                        x: .value ("Fixed", $0.category),
                        y: .value("Amount", $0.amount),
                        width: 70
                    )
                }
            }
            .frame(height: 200)
        }
    }
}

struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarChart(expenses: Expenses())
    }
}
