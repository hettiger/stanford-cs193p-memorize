//
//  ContainerTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 28.12.20.
//

import GameKit
@testable import Memorize
import XCTest

class ContainerTests: XCTestCase {
    func test_container_providesSharedInstance() {
        XCTAssertTrue((Container.shared as Any) is Container)
    }

    func test_container_providesRandomSource() {
        XCTAssertTrue((Container.shared.randomSource as Any) is GKRandomSource)
    }
}
