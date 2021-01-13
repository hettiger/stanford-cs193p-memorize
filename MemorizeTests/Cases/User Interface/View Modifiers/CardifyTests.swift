//
//  CardifyTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 12.01.21.
//

@testable import Memorize
import SwiftUI
import ViewInspector
import XCTest

private typealias ModifierContent = _ViewModifier_Content<Cardify>

extension ModifierContent: Inspectable {}

class CardifyTests: XCTestCase {
    var sut: Cardify!

    override func setUpWithError() throws {
        try super.setUpWithError()
        withFaceUp()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func withFaceUp() {
        sut = .init(isFaceUp: true, color: sut?.color ?? .accentColor)
    }

    func withFaceDown() {
        sut = .init(isFaceUp: false, color: sut?.color ?? .accentColor)
    }

    func assertIsViewModifier<T: ViewModifier>(_: T) {}

    func test_cardify_isViewModifier() {
        assertIsViewModifier(sut)
    }

    func test_cardify_isFaceUp_yieldsContent() {
        withFaceUp()
        let exp = XCTestExpectation(description: #function)
        sut.didAppear = { body in
            body.inspect { view in
                XCTAssertNoThrow(
                    try view.find(ViewType.ZStack.self)
                        .view(ModifierContent.self, 3)
                )
            }
            ViewHosting.expel()
            exp.fulfill()
        }
        let view = EmptyView().modifier(sut!)
        ViewHosting.host(view: view)
        wait(for: [exp], timeout: 0.1)
    }

    func test_cardify_isFaceDown_doesntYieldContent() {
        withFaceDown()
        let exp = XCTestExpectation(description: #function)
        sut.didAppear = { body in
            body.inspect { view in
                XCTAssertThrowsError(
                    try view.find(ViewType.ZStack.self)
                        .view(ModifierContent.self, 3)
                )
            }
            ViewHosting.expel()
            exp.fulfill()
        }
        let view = EmptyView().modifier(sut!)
        ViewHosting.host(view: view)
        wait(for: [exp], timeout: 0.1)
    }
}
