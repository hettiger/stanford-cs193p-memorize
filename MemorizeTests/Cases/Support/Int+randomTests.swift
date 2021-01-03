//
//  Int+randomTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 28.12.20.
//

@testable import Memorize
import XCTest

class Int_randomTests: XCTestCase {
    var randomSourceFake: RandomSourceFake!

    override func setUpWithError() throws {
        try super.setUpWithError()
        randomSourceFake = RandomSourceFake()
    }

    override func tearDownWithError() throws {
        randomSourceFake = nil
        try super.tearDownWithError()
    }

    func test_intRandomInUsing_returnsRandomIntInClosedRange() {
        let expectedRange = 2 ... 5
        let expectedInt = 4
        randomSourceFake.nextInt = expectedInt

        let actualInt = Int.random(in: expectedRange, using: randomSourceFake)

        XCTAssertEqual(expectedRange, randomSourceFake.lastRange)
        XCTAssertEqual(expectedInt, actualInt)
    }
}
