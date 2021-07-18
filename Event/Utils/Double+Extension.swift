//
//  Double+Extension.swift
//  Event
//
//  Created by João Luis dos Santos on 18/07/21.
//

import Foundation

enum CurrencyFormat: String {
    case real = "R$"
}

extension Double {
    func toCurrency(_ currency: CurrencyFormat) -> String {
        let toString = String(format: "%.2f", self)
        return "\(currency.rawValue) \(toString)".replacingOccurrences(of: ".", with: ",")
    }
}
