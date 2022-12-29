//
//  FormatStyle-LocalCurrency.swift
//  iExpense
//
//  Created by Lucas Lima on 25/12/22.
//

import Foundation

extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static var localCurrency: Self {
        .currency(code: Locale.current.currency?.identifier ?? "USD")
    }
}
