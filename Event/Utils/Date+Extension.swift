//
//  Date+Extension.swift
//  Event
//
//  Created by João Luis dos Santos on 18/07/21.
//

import Foundation

enum DateFormat: String {
    case ddMMYYYY = "dd/MM/YYYY"
}

extension Date {
    func toString(format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
        return dateFormatter.string(from: self)
    }
}
