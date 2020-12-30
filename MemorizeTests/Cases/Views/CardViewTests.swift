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
            CardView(card: .init(id: 0, content: "emoji", isFaceUp: isFaceUp, isMatched: isMatched))
    }

    func test_cardView_isFaceDown_doesNotShowEmoji() throws {
        withCard(isFaceUp: false)

        XCTAssertThrowsError(try sut.inspect().find(text: sut.card.content))
    }

    func test_cardView_isFaceUp_showsEmoji() throws {
        withCard(isFaceUp: true)

        XCTAssertNoThrow(try sut.inspect().find(text: sut.card.content))
    }

    func test_cardView_isMatched_doesNotShowShapeView() throws {
        withCard(isFaceUp: false, isMatched: true)
        
        XCTAssertThrowsError(try sut.inspect().find(ViewType.ZStack.self).shape(0))
    }

    func test_cardView_isFaceUpisMatched_showsShapeView() throws {
        withCard(isFaceUp: true, isMatched: true)
        
        XCTAssertNoThrow(try sut.inspect().find(ViewType.ZStack.self).shape(0))
    }
}
