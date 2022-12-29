//
//  ExpenseSection.swift
//  iExpense
//
//  Created by Lucas Lima on 25/12/22.
//

import SwiftUI

struct ExpenseSection: View {
    @Environment(\.editMode) private var editMode
    
    let title: String
    let expenses: [ExpenseItem]
    let deleteItems: (IndexSet) -> Void
    let moveItems: (IndexSet, Int) -> Void
    let handleDoneItem: (_ itemId: UUID) -> Void
    let moveItemsDisable: Bool
    let deleteItemsDisable: Bool
    
    func formatDate(date: Date) -> String {
        let formatter1 = DateFormatter()

        formatter1.dateStyle = .medium
        formatter1.timeStyle = .none

        return formatter1.string(from: date)
    }
    
    var body: some View {
        Section(title) {
            ForEach(expenses) { item in
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
                        handleDoneItem(item.id)
                    } label: {
                        Label("Check", systemImage: "checkmark")
                    }
                    .tint(.green)
                }
            }
            .onDelete(perform: deleteItems)
            .onMove(perform: moveItems)
            .moveDisabled(moveItemsDisable)
            .deleteDisabled(deleteItemsDisable)
        }
    }
}
