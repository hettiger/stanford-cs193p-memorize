//
//  String+IntSubscriptTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 27.12.20.
//

@testable import Memorize
import XCTest

class String_IntSubscriptTests: XCTestCase {
    func test_stringSubscriptIntIndex_returnsString() {
        let expectedString = "b"

        let actualString = "abc"[1]

        XCTAssertEqual(expectedString, actualString)
    }
}
