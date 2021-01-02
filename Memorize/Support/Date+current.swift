//
//  Date+current.swift
//  Memorize
//
//  Created by Martin Hettiger on 02.01.21.
//

import Foundation

extension Date {
    static var current: Date {
        __dateFactory()
    }
}

internal var __dateFactory: () -> Date = Date.init
