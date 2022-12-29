//
//  LogsView.swift
//  MyExpenses
//
//  Created by Lucas Lima on 29/12/22.
//

import SwiftUI

struct LogsView: View {
    @ObservedObject var expenses: Expenses
    @AppStorage("SelectedCategory") var categorySelected = "tshirt"
    @State private var searchText = ""
    @State private var sortBySelection = "calendar"
    @State private var sortBySelections = ["calendar", "dollarsign"]
    @State private var disabledSortByCategory = true
    
    var searchResults: [ExpenseItem] {
        if searchText.isEmpty {
            var expensesFiltered = expenses.items
            
            if !disabledSortByCategory {
                expensesFiltered = expenses.items.filter { $0.category == categorySelected }
            }
            
            if expensesFiltered.count > 1 {
                if sortBySelection == "calendar" {
                    return expensesFiltered.sorted(by: { $0.data.compare($1.data) == .orderedDescending })
                } else {
                    return expensesFiltered.sorted(by: {
                        $0.amount > $1.amount
                    })
                }
            } else {
                return expensesFiltered
            }
        } else {
            let expensesFiltered = expenses.items.filter { $0.name.contains(searchText) }
            
            return expensesFiltered.filter { $0.category == categorySelected }
        }
    }
    
    func formatDate(date: Date) -> String {
        let formatter1 = DateFormatter()

        formatter1.dateStyle = .medium
        formatter1.timeStyle = .none

        return formatter1.string(from: date)
    }
    
    func handleDoneItem(itemId: UUID) {
        if let row = expenses.items.firstIndex(where: {$0.id == itemId}) {
            expenses.items[row].isDone = !expenses.items[row].isDone
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Text("Sort by")
                    
                    Spacer()
                    
                    Picker("", selection: $sortBySelection) {
                        ForEach(sortBySelections, id: \.self) { icon in
                            Image(systemName: icon)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 180)
                }
                
                HStack {
                    NavigationLink {
                        selectCategoryView()
                    } label: {
                        HStack {
                            Text("Sort by category:")
                            Image(systemName: categorySelected)
                                .foregroundColor(.accentColor)
                        }
                    }
                }
                
                HStack {
                    Toggle("Disable sort by category", isOn: $disabledSortByCategory)
                }
                
                Section("Transactions") {
                    if searchResults.isEmpty {
                        HStack {
                            Text("No transactions with the category:")
                            Image(systemName: categorySelected)
                                .foregroundColor(.accentColor)
                        }
                    } else {
                        ForEach(searchResults) { item in
                            HStack {
                                Image(systemName: item.category)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(item.name)
                                        .font(.headline)
                                    
                                    Text(formatDate(date: item.data))
                                        .font(.subheadline)
                                }
                                
                                Spacer()
                                
                                VStack(spacing: 5) {
                                    Text(item.amount, format: .localCurrency)
                                    Text(item.type)
                                }
                            }
                            .opacity(item.isDone ? 0.2 : 1)
                            .swipeActions(edge: .leading) {
                                Button {
                                    handleDoneItem(itemId: item.id)
                                } label: {
                                    Label("Check", systemImage: "checkmark")
                                }
                                .tint(.green)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Expenses logs")
            .searchable(text: $searchText)
        }
    }
}

struct LogsView_Previews: PreviewProvider {
    static var previews: some View {
        LogsView(expenses: Expenses())
    }
}
