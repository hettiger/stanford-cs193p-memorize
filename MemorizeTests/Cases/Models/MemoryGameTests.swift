//
//  MemoryGameTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 27.12.20.
//

import GameKit
@testable import Memorize
import XCTest

/// Memory Game Tests
///
/// Tests do not cover bonus time because I did not want to touch the instructors code.
/// Someone might copy it and replacements of `Date()` calls might lead to errors …
class MemoryGameTests: XCTestCase {
    typealias Game = MemoryGame<Character>

    let container = ContainerFactory.makeEmojiMemoryGameContainer()

    var sut: Game!

    var userDefaultsFake: UserDefaultsFake {
        container.resolve(UserDefaults.self) as! UserDefaultsFake
    }

    var randomSourceFake: RandomSourceFake {
        container.resolve(RandomSource.self) as! RandomSourceFake
    }

    override func setUp() {
        super.setUp()
        container.autoregister(UserDefaults.self, initializer: UserDefaultsFake.init)
            .inObjectScope(.container)
        container.autoregister(RandomSource.self, initializer: RandomSourceFake.init)
            .inObjectScope(.container)
        withContents("🐶🐱🐭🐰")
    }

    override func tearDown() {
        sut = nil
        container.removeAll()
        super.tearDown()
    }

    func withContents(_ newContents: String) {
        container.register(Game.self) { resolver in
            resolver.resolve(Game.self, argument: Game.Theme(
                name: "Test",
                contents: newContents
            ))!
        }
        sut = container.resolve(Game.self)!
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

    func test_memoryGame_providesCards() {
        XCTAssertTrue((sut.cards as Any) is [Game.Card])
    }

    func test_memoryGame_cardsCountIsDoubleTheNumberOfThemeContents() {
        XCTAssertTrue(sut.cards.count == sut.theme.contents.count * 2)
    }

    func test_memoryGame_themeWithZeroContents_cardsCountIsZero() {
        withContents("")
        XCTAssertTrue(sut.cards.count == 0)
    }

    func test_memoryGame_providesShuffledCards() {
        let expectedCards = "dbca".cards
        randomSourceFake.shuffle = { _ in expectedCards }

        withContents("")

        XCTAssertEqual(expectedCards, sut.cards)
    }

    func test_memoryGame_providesState() {
        XCTAssertTrue((sut.state as Any) is Game.State)
    }

    func test_memoryGame_providesScore() {
        XCTAssertTrue((sut.score as Any) is Int)
    }

    func test_memoryGame_providesHighscore() {
        XCTAssertTrue((sut.score as Any) is Int)
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

    func test_score_doesNotChangeHighscoreIfScoreIsLower() {
        userDefaultsFake.set(10, forKey: UserDefaults.Key.highscore.rawValue)

        XCTAssertEqual(0, sut.score)
        XCTAssertEqual(10, sut.highscore)

        sut.choose(card: sut.cards[0])
        sut.choose(card: sut.cards[1])

        XCTAssertEqual(2, sut.score)
        XCTAssertEqual(10, sut.highscore)
    }

    func test_score_updatesHighscoreIfScoreIsGreater() {
        userDefaultsFake.set(1, forKey: UserDefaults.Key.highscore.rawValue)

        XCTAssertEqual(0, sut.score)
        XCTAssertEqual(1, sut.highscore)

        sut.choose(card: sut.cards[0])
        sut.choose(card: sut.cards[1])

        XCTAssertEqual(2, sut.score)
        XCTAssertEqual(2, sut.highscore)
    }
}
