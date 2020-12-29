//
//  CardViewTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 26.12.20.
//

@testable import Memorize
import ViewInspector
import XCTest

extension CardView: Inspectable {}

class CardViewTests: XCTestCase {
    func test_cardView_isFaceDown_doesNotShowEmoji() throws {
        let sut = CardView(card: .init(id: 0, content: "emoji"))

        let visibleText = try? sut.inspect().geometryReader().zStack().text(2).string()

        XCTAssertNil(visibleText)
    }

    func test_cardView_isFaceUp_showsEmoji() throws {
        let sut = CardView(card: .init(id: 0, content: "emoji", isFaceUp: true))

        let visibleText = try sut.inspect().geometryReader().zStack().text(2).string()

        XCTAssertEqual(sut.card.content, visibleText)
    }
}
