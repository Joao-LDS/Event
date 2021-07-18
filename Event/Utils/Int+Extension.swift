//
//  Int+Extension.swift
//  Event
//
//  Created by João Luis dos Santos on 18/07/21.
//

import Foundation

extension Int {
    var timestampToDate: Date {
        let timeInt = TimeInterval(self)
        return Date(timeIntervalSince1970: timeInt)
    }
}
