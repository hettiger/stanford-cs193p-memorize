//
//  EmojiMemoryGameTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 27.12.20.
//

@testable import Memorize
import XCTest

class EmojiMemoryGameTests: XCTestCase {
    var sut: EmojiMemoryGame!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = EmojiMemoryGame()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_emojiMemoryGame_providesCards() {
        XCTAssertTrue((sut.cards as Any) is [MemoryGame<String>.Card])
    }
    
    func test_emojiMemoryGame_whenFaceDownCardIsChosen_cardIsFaceUp() {
        XCTAssertFalse(sut.cards.first!.isFaceUp)
        
        sut.choose(card: sut.cards.first!)
        
        XCTAssertTrue(sut.cards.first!.isFaceUp)
    }
    
    func test_emojiMemoryGame_whenFaceUpCardIsChosen_cardIsFaceUp() {
        sut.choose(card: sut.cards.first!)

        XCTAssertTrue(sut.cards.first!.isFaceUp)

        sut.choose(card: sut.cards.first!)

        XCTAssertFalse(sut.cards.first!.isFaceUp)
    }
}
