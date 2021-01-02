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

    override func setUpWithError() throws {
        try super.setUpWithError()
        withContents("🐶🐱🐭🐰")
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func withContents(_ newContents: String) {
        sut = Game(themes: [.init(name: "Test", contents: newContents, randomSource: nil)])
    }

    func test_memoryGame_zeroThemes_initializesWithEmptyTheme() throws {
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

        XCTAssertEqual([sut.cards[0].id], sut.cards.filter(\.isFaceUp).map(\.id))
        XCTAssertTrue(sut.state == .oneCardFaceUp(sut.cards[0].id))
    }

    func test_memoryGameChoose_oneCardFaceUp_stateBecomesTwoCardsFaceUp() {
        sut.choose(card: sut.cards[0])

        sut.choose(card: sut.cards[1])

        XCTAssertEqual(
            [sut.cards[0].id, sut.cards[1].id],
            sut.cards.filter(\.isFaceUp).map(\.id)
        )
        XCTAssertTrue(sut.state == .twoCardsFaceUp(sut.cards[0].id, sut.cards[1].id))
    }

    func test_memoryGameChooseAlreadyFaceUpCard_oneCardFaceUp_stateDoesNotChange() {
        sut.choose(card: sut.cards[0])

        sut.choose(card: sut.cards[0])

        XCTAssertEqual([sut.cards[0].id], sut.cards.filter(\.isFaceUp).map(\.id))
        XCTAssertTrue(sut.state == .oneCardFaceUp(sut.cards[0].id))
    }

    func test_memoryGameChooseMatch_oneCardFaceUp_marksCardsAsMatched() {
        withContents("aabb")
        sut.choose(card: sut.cards[0])

        sut.choose(card: sut.cards[1])

        XCTAssertEqual(
            [sut.cards[0].id, sut.cards[1].id],
            sut.cards.filter(\.isMatched).map(\.id)
        )
    }

    func test_memoryGameChoose_twoCardsFaceUp_stateBecomesOneCardFaceUp() {
        sut.choose(card: sut.cards[0])
        sut.choose(card: sut.cards[1])

        sut.choose(card: sut.cards[2])

        XCTAssertEqual([sut.cards[2].id], sut.cards.filter(\.isFaceUp).map(\.id))
        XCTAssertTrue(sut.state == .oneCardFaceUp(sut.cards[2].id))
    }

    func test_memoryGameChooseAlreadyFaceUpCard_twoCardsFaceUp_stateDoesNotChange() {
        func assertIsExpectedState() {
            XCTAssertEqual(
                [sut.cards[0].id, sut.cards[1].id],
                sut.cards.filter(\.isFaceUp).map(\.id)
            )
            XCTAssertTrue(sut.state == .twoCardsFaceUp(sut.cards[0].id, sut.cards[1].id))
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
            XCTAssertEqual([sut.cards[2].id], sut.cards.filter(\.isFaceUp).map(\.id))
            XCTAssertTrue(sut.state == .oneCardFaceUp(sut.cards[2].id))
        }

        withContents("aabb")
        sut.choose(card: sut.cards[0])
        sut.choose(card: sut.cards[1])
        sut.choose(card: sut.cards[2])

        assertIsExpectedState()

        sut.choose(card: sut.cards[0])

        assertIsExpectedState()
    }
}
