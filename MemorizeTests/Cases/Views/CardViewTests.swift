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
    var sut: CardView!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        withCard(isFaceUp: false)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func withCard(isFaceUp: Bool) {
        sut = CardView(card: .init(id: 0, content: "emoji", isFaceUp: isFaceUp))
    }
    
    func test_cardView_isFaceDown_doesNotShowEmoji() throws {
        withCard(isFaceUp: false)
        
        let text = try? sut.inspect().find(text: sut.card.content)

        XCTAssertNil(text)
    }

    func test_cardView_isFaceUp_showsEmoji() throws {
        withCard(isFaceUp: true)

        let text = try? sut.inspect().find(text: sut.card.content)

        XCTAssertNotNil(text)
    }
}
