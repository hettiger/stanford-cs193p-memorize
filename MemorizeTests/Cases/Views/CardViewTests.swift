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
        let sut = CardView(emoji: "emoji")

        let visibleText = try? sut.inspect().zStack().text(2).string()

        XCTAssertNil(visibleText)
    }

    func test_cardView_isFaceUp_showsEmoji() throws {
        let sut = CardView(isFaceUp: true, emoji: "emoji")

        let visibleText = try sut.inspect().zStack().text(2).string()

        XCTAssertEqual(sut.emoji, visibleText)
    }
}
