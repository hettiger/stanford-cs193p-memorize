//
//  EmojiMemoryGameTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 27.12.20.
//

@testable import Memorize
import XCTest

class EmojiMemoryGameTests: XCTestCase {
    typealias Game = EmojiMemoryGame.Game

    var sut: EmojiMemoryGame!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = EmojiMemoryGame()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_emojiMemoryGame_providesTheme() {
        XCTAssertTrue((sut.theme as Any) is Game.Theme)
    }
    
    func test_emojiMemoryGame_providesCards() {
        XCTAssertTrue((sut.cards as Any) is [Game.Card])
    }

    func test_emojiMemoryGameChoose_isFaceDown_setsIsFaceUpToTrue() {
        sut.choose(card: sut.cards.first!)

        XCTAssertTrue(sut.cards.first!.isFaceUp)
    }
    
    func test_emojiMemoryGameRestart_themeChanges() {
        let initialTheme = sut.theme
        
        sut.restart()
        
        XCTAssertNotEqual(initialTheme, sut.theme)
    }
}
