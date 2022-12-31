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
                    if expenses.items.isEmpty {
                        Text("No Transactions")
                    }
                    else if searchResults.isEmpty {
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
                                    
                                    Text(FormatData().formatDate(date: item.data))
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
                                    FuncHelper(expenses: expenses).handleDoneItem(itemId: item.id)
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
