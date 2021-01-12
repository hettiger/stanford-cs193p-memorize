//
//  CardViewTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 26.12.20.
//

@testable import Memorize
import SwiftUI
import ViewInspector
import XCTest

extension CardView: Inspectable {}
extension Pie: Inspectable {}

class CardViewTests: XCTestCase {
    var sut: CardView!

    override func setUpWithError() throws {
        try super.setUpWithError()
        withCard(isFaceUp: false)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func withCard(isFaceUp: Bool = false, isMatched: Bool = false) {
        sut =
            CardView(card: .init(id: 0, content: "e", isFaceUp: isFaceUp, isMatched: isMatched))
    }

    func test_cardView_withFaceDown_isNotEmpty() throws {
        withCard(isFaceUp: false, isMatched: false)

        XCTAssertFalse(try sut.inspect().isEmpty)
    }

    func test_cardView_withFaceDownAndMatchedCard_isEmpty() throws {
        withCard(isFaceUp: false, isMatched: true)

        XCTAssertTrue(try sut.inspect().isEmpty)
    }

    func test_cardView_withFaceUp_isNotEmpty() throws {
        withCard(isFaceUp: true, isMatched: false)

        XCTAssertFalse(try sut.inspect().isEmpty)
    }

    func test_cardView_withFaceUpAndMatchedCard_isNotEmpty() throws {
        withCard(isFaceUp: true, isMatched: true)

        XCTAssertFalse(try sut.inspect().isEmpty)
    }

    func test_cardView_isFaceUp_showsPie() throws {
        withCard(isFaceUp: true)

        XCTAssertNoThrow(try sut.inspect().find(Pie.self))
    }

    func test_cardView_isFaceUp_showsEmoji() throws {
        withCard(isFaceUp: true)

        XCTAssertNoThrow(try sut.inspect().find(text: String(sut.card.content)))
    }
}
