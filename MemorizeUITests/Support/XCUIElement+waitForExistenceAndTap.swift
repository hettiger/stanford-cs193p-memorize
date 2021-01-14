//
//  XCUIElement+waitForExistenceAndTap.swift
//  MemorizeUITests
//
//  Created by Martin Hettiger on 14.01.21.
//

import XCTest

extension XCUIElement {
    /// Waits the specified amount of time for the element’s `exists` property to become `true`;
    /// asserts that the element’s `exists` property has become `true`; then taps the element.
    ///
    /// - Parameters:
    ///   - timeout: The amount of time to wait for the element’s `exists` property to become `true`.
    ///   - force: The flag whether a tap should be forced even if the element's `isHittable` property is `false`.
    func waitForExistenceAndTap(timeout: TimeInterval = 2, force: Bool? = true) {
        XCTAssertTrue(waitForExistence(timeout: timeout))
        guard force == true, !isHittable else { tap(); return }
        coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
    }
}
