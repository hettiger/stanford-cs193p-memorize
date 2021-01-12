//
//  CardifyTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 12.01.21.
//

@testable import Memorize
import SwiftUI
import XCTest

/// Cardify Tests
///
/// Tests are not complete because Custom ViewModifier Tests as described in ViewInspector
/// docs do not seem very beneficial. Could be wrong; maybe coming back to this later.
/// For now the other tests should be covering this pretty well and then there's also
/// the SwiftUI Previews …
///
/// - ToDo: Review test case
/// - See: https://github.com/nalexn/ViewInspector/blob/master/guide.md#custom-viewmodifier
class CardifyTests: XCTestCase {
    var sut: Cardify!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Cardify(isFaceUp: true, color: .accentColor)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func assertIsViewModifier<T: ViewModifier>(_: T) {}

    func test_cardify_isViewModifier() {
        assertIsViewModifier(sut)
    }
}
