//
//  EmojiMemoryGameTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 27.12.20.
//

import GameKit
@testable import Memorize
import XCTest

class EmojiMemoryGameTests: XCTestCase {
    typealias Game = EmojiMemoryGame.Game

    var sut: EmojiMemoryGame!
    var randomSource: RandomSource!
    var randomSourceFake: RandomSourceFake!

    override func setUpWithError() throws {
        try super.setUpWithError()
        randomSource = EmojiMemoryGame.randomSource
        randomSourceFake = RandomSourceFake()
        EmojiMemoryGame.randomSource = randomSourceFake
        sut = EmojiMemoryGame()
    }

    override func tearDownWithError() throws {
        EmojiMemoryGame.randomSource = randomSource
        randomSourceFake = nil
        sut = nil
        try super.tearDownWithError()
    }

    func test_emojiMemoryGame_providesTheme() {
        XCTAssertTrue((sut.theme as Any) is Game.Theme)
    }

    func test_emojiMemoryGame_providesCards() {
        XCTAssertTrue((sut.cards as Any) is [Game.Card])
    }

    func test_emojiMemoryGame_providesScore() {
        XCTAssertTrue((sut.score as Any) is Int)
    }

    func test_emojiMemoryGame_providesHighscore() {
        XCTAssertTrue((sut.highscore as Any) is Int)
    }

    func test_emojiMemoryGameChoose_isFaceDown_setsIsFaceUpToTrue() {
        sut.choose(card: sut.cards.first!)

        XCTAssertTrue(sut.cards.first!.isFaceUp)
    }

    func test_emojiMemoryGameStartFresh_themeChanges() {
        let initialTheme = sut.theme

        sut.startFresh()

        XCTAssertNotEqual(initialTheme, sut.theme)
    }

    func test_emojiMemoryGameStartFresh_startsNewGameWithRandomOtherTheme() {
        let initialTheme = sut.theme
        let expectedThemes = [Game.Theme(name: "expected", contents: "a")]

        randomSourceFake.shuffle = {
            guard let themes = $0 as? [Game.Theme] else { return [] }
            XCTAssertFalse(themes.contains(where: { $0.name == initialTheme.name }))
            return expectedThemes
        }

        sut.startFresh()

        XCTAssertEqual(expectedThemes[0], sut.theme)
    }

    func test_emojiMemoryGameStartFresh_filteredAllThemes_startsNewGameWithFirstTheme() {
        randomSourceFake.shuffle = { _ in [] }

        XCTAssertNoThrow(sut.startFresh())
    }
}
