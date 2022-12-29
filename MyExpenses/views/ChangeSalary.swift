//
//  ChangeSalary.swift
//  MyExpenses
//
//  Created by Lucas Lima on 26/12/22.
//

import SwiftUI

struct ChangeSalary: View {
    @Environment(\.dismiss) var dismiss
    @Binding var salary: Double
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Expense name", value: $salary, format: .localCurrency)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Change salary")
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}
