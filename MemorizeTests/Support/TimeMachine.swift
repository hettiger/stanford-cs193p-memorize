//
//  TimeMachine.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 02.01.21.
//

import Foundation
@testable import Memorize

class TimeMachine {
    static let shared = TimeMachine()

    var isActive = false
    var date = Date()

    private init() {
        __dateFactory = makeDate
    }

    func makeDate() -> Date {
        isActive ? date : Date()
    }
}
