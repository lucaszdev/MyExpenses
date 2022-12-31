//
//  FormatData.swift
//  MyExpenses
//
//  Created by Lucas Lima on 31/12/22.
//

import Foundation

class FormatData {
    func formatDate(date: Date) -> String {
        let formatter1 = DateFormatter()

        formatter1.dateStyle = .medium
        formatter1.timeStyle = .none

        return formatter1.string(from: date)
    }
}
