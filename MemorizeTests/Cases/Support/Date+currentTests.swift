//
//  Date+currentTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 03.01.21.
//

@testable import Memorize
import XCTest

class Date_currentTests: XCTestCase {
    var timeMachine = TimeMachine.shared

    override func setUpWithError() throws {
        try super.setUpWithError()
        timeMachine.isActive = true
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        timeMachine.isActive = false
    }

    func test_current_returnsDateFromTimeMachine() {
        timeMachine.date = Date().addingTimeInterval(10)

        XCTAssertEqual(timeMachine.date, Date.current)
    }

    func test_current_returnsActualCurrentDateIfTimeMachineIsInactive() {
        timeMachine.date = Date().addingTimeInterval(10)
        timeMachine.isActive = false

        XCTAssertNotEqual(timeMachine.date, Date.current)
    }
}
