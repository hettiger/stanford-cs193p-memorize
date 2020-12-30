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
    var sut: MemoryGame<String>!
    var contents: [Character]!
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
        contents = Array(newContents)
        sut = MemoryGame<String>(
            numberOfPairsOfCards: contents.count,
            randomSource: randomSourceFake
        ) { pairIndex in
            String(contents[pairIndex])
        }
    }

    func withShuffledCards(_ string: String) {
        randomSourceFake.shuffle = { _ in string.cards }

        withContents("") // input does not matter
    }

    func test_memoryGame_providesMemoryGameCards() {
        XCTAssertTrue((sut.cards as Any) is [MemoryGame<String>.Card])
    }

    func test_memoryGame_providesPairsOfMemoryGameCards() {
        let expectedNumberOfPairsOfCards = contents.count * 2

        let actualNumberOfPairsOfCards = sut.cards.count

        XCTAssertGreaterThan(expectedNumberOfPairsOfCards, 1)
        XCTAssertEqual(expectedNumberOfPairsOfCards, actualNumberOfPairsOfCards)
    }

    func test_memoryGame_shufflesCards() {
        let expected = "aabb"

        withShuffledCards(expected)

        XCTAssertEqual(expected.cards.map(\.id), sut.cards.map(\.id))
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
        withShuffledCards("aabb")
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

        withShuffledCards("aabb")
        sut.choose(card: sut.cards[0])
        sut.choose(card: sut.cards[1])
        sut.choose(card: sut.cards[2])

        assertIsExpectedState()

        sut.choose(card: sut.cards[0])

        assertIsExpectedState()
    }
}
