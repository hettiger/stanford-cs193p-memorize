//
//  MemoryGameTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 27.12.20.
//

import GameKit
@testable import Memorize
import XCTest

class MemoryGameTests: XCTestCase {
    typealias Game = MemoryGame<Character>

    var sut: Game!
    var randomSourceFake: RandomSourceFake!

    override func setUpWithError() throws {
        try super.setUpWithError()
        randomSourceFake = RandomSourceFake()
        withContents("🐶🐱🐭🐰")
    }

    override func tearDownWithError() throws {
        randomSourceFake = nil
        sut = nil
        try super.tearDownWithError()
    }

    func withContents(_ newContents: String) {
        sut = Game(
            themes: [.init(name: "Test", contents: newContents, randomSource: nil)],
            randomSource: randomSourceFake
        )
    }

    func withMatch() {
        withContents("aabb")
        sut.choose(card: sut.cards[0])

        sut.choose(card: sut.cards[1])
    }

    func test_memoryGameState_isHashable() {
        XCTAssertTrue((sut.state as Any) is AnyHashable)
    }

    func test_memoryGame_providesTheme() {
        XCTAssertTrue((sut.theme as Any) is Game.Theme)
    }

    func test_memoryGame_providesThemes() {
        XCTAssertTrue((sut.themes as Any) is [Game.Theme])
    }

    func test_memoryGame_providesCards() {
        XCTAssertTrue((sut.cards as Any) is [Game.Card])
    }

    func test_memoryGame_providesState() {
        XCTAssertTrue((sut.state as Any) is Game.State)
    }

    func test_memoryGame_providesScore() {
        XCTAssertTrue((sut.score as Any) is Int)
    }

    func test_memoryGame_zeroThemes_initializesWithEmptyTheme() {
        sut = Game(themes: [])

        XCTAssertEqual("Empty", sut.theme.name)
        XCTAssertEqual(1, sut.themes.count)
        XCTAssertEqual(0, sut.cards.count)
    }

    func test_memoryGame_startsInNoFaceUpCardState() {
        XCTAssertEqual(0, sut.cards.filter { $0.isFaceUp }.count)
        XCTAssertTrue(sut.state == .noCardFaceUp)
    }

    func test_memoryGameChoose_noCardFaceUp_stateBecomesOneCardFaceUp() {
        sut.choose(card: sut.cards[0])

        XCTAssertEqual([sut.cards[0]], sut.cards.filter(\.isFaceUp))
        XCTAssertTrue(sut.state == .oneCardFaceUp(sut.cards[0]))
    }

    func test_memoryGameChoose_oneCardFaceUp_stateBecomesTwoCardsFaceUp() {
        sut.choose(card: sut.cards[0])

        sut.choose(card: sut.cards[1])

        XCTAssertEqual(
            [sut.cards[0], sut.cards[1]],
            sut.cards.filter(\.isFaceUp)
        )
        XCTAssertTrue(sut.state == .twoCardsFaceUp(sut.cards[0], sut.cards[1]))
    }

    func test_memoryGameChooseAlreadyFaceUpCard_oneCardFaceUp_stateDoesNotChange() {
        sut.choose(card: sut.cards[0])

        sut.choose(card: sut.cards[0])

        XCTAssertEqual([sut.cards[0]], sut.cards.filter(\.isFaceUp))
        XCTAssertTrue(sut.state == .oneCardFaceUp(sut.cards[0]))
    }

    func test_memoryGameChooseMatch_oneCardFaceUp_marksCardsAsMatched() {
        withMatch()

        XCTAssertEqual(
            [sut.cards[0], sut.cards[1]],
            sut.cards.filter(\.isMatched)
        )
    }

    func test_memoryGameChoose_twoCardsFaceUp_stateBecomesOneCardFaceUp() {
        sut.choose(card: sut.cards[0])
        sut.choose(card: sut.cards[1])

        sut.choose(card: sut.cards[2])

        XCTAssertEqual([sut.cards[2]], sut.cards.filter(\.isFaceUp))
        XCTAssertTrue(sut.state == .oneCardFaceUp(sut.cards[2]))
    }

    func test_memoryGameChooseAlreadyFaceUpCard_twoCardsFaceUp_stateDoesNotChange() {
        func assertIsExpectedState() {
            XCTAssertEqual(
                [sut.cards[0], sut.cards[1]],
                sut.cards.filter(\.isFaceUp)
            )
            XCTAssertTrue(sut.state == .twoCardsFaceUp(sut.cards[0], sut.cards[1]))
        }

        sut.choose(card: sut.cards[0])
        sut.choose(card: sut.cards[1])

        sut.choose(card: sut.cards[0])

        assertIsExpectedState()

        sut.choose(card: sut.cards[1])

        assertIsExpectedState()
    }

    func test_memoryGameChooseAlreadyMatchedCard_oneCardFaceUp_stateDoesNotChange() {
        func assertIsExpectedState() {
            XCTAssertEqual([sut.cards[2]], sut.cards.filter(\.isFaceUp))
            XCTAssertTrue(sut.state == .oneCardFaceUp(sut.cards[2]))
        }

        withMatch()
        sut.choose(card: sut.cards[2])

        assertIsExpectedState()

        sut.choose(card: sut.cards[0])

        assertIsExpectedState()
    }

    func test_memoryGameRestart_oneTheme_startsWithOneAndOnlyThemeRestartsWithSameTheme() {
        let expectedTheme = sut.theme
        let expectedState = sut.state
        sut.choose(card: sut.cards[0])

        XCTAssertEqual(expectedTheme, sut.theme)
        XCTAssertNotEqual(expectedState, sut.state)
        XCTAssertTrue(sut.cards[0].isFaceUp)

        sut.restart()

        XCTAssertEqual(expectedTheme, sut.theme)
        XCTAssertEqual(expectedState, sut.state)
        XCTAssertFalse(sut.cards[0].isFaceUp)
    }

    func test_memoryGameRestart_twoThemes_startsWithFirstThemeRestartsWithOtherTheme() {
        let initialTheme = Game.Theme(name: "initial", contents: "ab", randomSource: nil)
        let expectedTheme = Game.Theme(name: "expected", contents: "cd", randomSource: nil)
        sut = Game(themes: [initialTheme, expectedTheme], randomSource: randomSourceFake)

        XCTAssertEqual(initialTheme, sut.theme)

        sut.restart()

        XCTAssertEqual(expectedTheme, sut.theme)
    }

    func test_memoryGameRestart_manyThemes_startsWithRandomThemeRestartsWithRandomOtherTheme() {
        let initialTheme = Game.Theme(name: "initial", contents: "ab", randomSource: nil)
        let expectedTheme = Game.Theme(name: "expected", contents: "cd", randomSource: nil)
        let someTheme = Game.Theme(name: "some", contents: "cd", randomSource: nil)
        let themes = [someTheme, someTheme, initialTheme, someTheme, expectedTheme, someTheme]

        randomSourceFake.shuffle = { _ in
            [initialTheme, someTheme, someTheme, expectedTheme, someTheme]
        }

        sut = Game(themes: themes, randomSource: randomSourceFake)

        XCTAssertEqual(initialTheme, sut.theme)

        randomSourceFake.shuffle = { _ in
            [expectedTheme, someTheme, someTheme, someTheme, someTheme]
        }

        sut.restart()

        XCTAssertEqual(expectedTheme, sut.theme)
    }

    func test_memoryGameRestart_score_resetsScoreToZero() {
        withMatch()

        sut.restart()

        XCTAssertEqual(0, sut.score)
    }

    func test_score_newGame_isZero() {
        XCTAssertEqual(0, sut.score)
    }

    func test_score_match_increasesByTwo() {
        withMatch()

        XCTAssertEqual(2, sut.score)
    }
    
    func test_score_matchWithOnePreviouslySeenCard_increasesByTwo() {
        sut.choose(card: sut.cards[0])
        sut.choose(card: sut.cards[2])
        sut.choose(card: sut.cards[3])

        XCTAssertEqual(0, sut.score)
        
        sut.choose(card: sut.cards[2])
        
        XCTAssertEqual(2, sut.score)
    }
    
    func test_score_matchWithTwoPreviouslySeenCards_increasesByTwo() {
        sut.choose(card: sut.cards[0])
        sut.choose(card: sut.cards[2])
        sut.choose(card: sut.cards[1])
        sut.choose(card: sut.cards[3])

        XCTAssertEqual(0, sut.score)
        
        sut.choose(card: sut.cards[0])
        sut.choose(card: sut.cards[1])
        
        XCTAssertEqual(2, sut.score)
    }

    func test_score_mismatchWithOnePreviouslySeenCard_penalizesOnePoint() {
        sut.choose(card: sut.cards[0])
        sut.choose(card: sut.cards[2])
        sut.choose(card: sut.cards[3])

        XCTAssertEqual(0, sut.score)

        sut.choose(card: sut.cards[0])

        XCTAssertEqual(-1, sut.score)
    }

    func test_score_mismatchWithTwoPreviouslySeenCards_penalizesTwoPoints() {
        sut.choose(card: sut.cards[0])
        sut.choose(card: sut.cards[2])
        sut.choose(card: sut.cards[3])
        sut.choose(card: sut.cards[5])

        XCTAssertEqual(0, sut.score)

        sut.choose(card: sut.cards[0])
        sut.choose(card: sut.cards[2])

        XCTAssertEqual(-2, sut.score)
    }
}
