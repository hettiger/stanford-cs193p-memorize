//
//  PieTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 12.01.21.
//

@testable import Memorize
import SwiftUI
import XCTest

class PieTests: XCTestCase {
    var sut: Pie!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Pie(startAngle: Angle(), endAngle: Angle())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func assertIsShape<T: Shape>(_: T) {}

    func test_pie_isShape() {
        assertIsShape(sut)
    }

    func test_pie_acceptsOptionalClockwiseArgument() {
        sut = Pie(startAngle: Angle(), endAngle: Angle(), clockwise: true)
    }
}
