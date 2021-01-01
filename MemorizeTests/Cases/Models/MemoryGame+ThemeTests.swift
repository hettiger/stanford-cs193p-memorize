//
//  MemoryGame+ThemeTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 01.01.21.
//

import GameKit
@testable import Memorize
import XCTest

class MemoryGame_ThemeTests: XCTestCase {
    typealias ContentType = String
    typealias Game = MemoryGame<ContentType>

    var sut: MemoryGame<String>.Theme!
    var randomSourceFake: RandomSourceFake!

    override func setUpWithError() throws {
        try super.setUpWithError()
        randomSourceFake = RandomSourceFake()
        sut = .init(
            name: "Name",
            contents: [],
            numberOfCards: 0,
            color: .clear,
            randomSource: randomSourceFake
        )
    }

    override func tearDownWithError() throws {
        randomSourceFake = nil
        sut = nil
        try super.tearDownWithError()
    }

    func withContents(_ contents: Set<ContentType>) {
        sut = .init(
            name: sut.name,
            contents: contents,
            numberOfCards: sut.numberOfCards,
            color: sut.color,
            randomSource: randomSourceFake
        )
    }

    func withNumberOfCards(_ numberOfCards: Int?) {
        sut = .init(
            name: sut.name,
            contents: sut.contents,
            numberOfCards: numberOfCards,
            color: sut.color,
            randomSource: randomSourceFake
        )
    }

    func test_themeNumberOfPairsOfCards_evenNumberOfCards_returnsNumberOfCardsDividedByTwo() {
        withNumberOfCards(4)

        XCTAssertEqual(2, sut.numberOfPairsOfCards)
    }

    func test_themeNumberOfPairsOfCards_unevenNumberOfCards_returnsRoundedDownNumberOfPairsOfCards(
    ) {
        withNumberOfCards(5)

        XCTAssertEqual(2, sut.numberOfPairsOfCards)
    }

    func test_themeNumberOfPairsOfCards_negativeNumberOfCards_returnsZero() {
        withNumberOfCards(-10)

        XCTAssertEqual(0, sut.numberOfPairsOfCards)
    }

    func test_themeNumberOfPairsOfCards_zeroNumberOfCards_returnsZero() {
        withNumberOfCards(0)

        XCTAssertEqual(0, sut.numberOfPairsOfCards)
    }

    func test_themeNumberOfPairsOfCards_nilNumberOfCards_returnsRandomNumberOfPairsOfCards() {
        randomSourceFake.nextInt = 4
        withNumberOfCards(nil)

        XCTAssertEqual(4, sut.numberOfPairsOfCards)
    }

    func test_themeNumberOfPairsOfCards_nilNumberOfCards_randomSourceUsesAppropriateUppderBound() {
        let contentsData: [Set<ContentType>] = [
            [],
            ["a"],
            ["a", "b"],
            ["a", "b", "c"],
            ["a", "b", "c", "d"],
        ]

        for contents in contentsData {
            let lowerBound = min(2, contents.count)
            let upperBound = contents.count
            withNumberOfCards(nil)
            withContents(contents)

            _ = sut.numberOfPairsOfCards

            XCTAssertEqual(upperBound + 1 - lowerBound, randomSourceFake.lastUpperBound)
        }
    }

    func test_themeCards_emptyContents_returnsZeroCards() {
        withContents([])

        XCTAssertEqual(0, sut.cards.count)
    }

    func test_themeCards_contents_returnsTwoCardsForEachPairInNumberOfPairsOfCards() {
        withContents(["a", "b", "c", "d"])

        XCTAssertEqual(2 * sut.numberOfPairsOfCards, sut.cards.count)
    }

    func test_themeCards_returnsShuffledCards() {
        let expectedCards = "dbca".cards
        randomSourceFake.shuffle = { _ in expectedCards }

        XCTAssertEqual(expectedCards.map(\.id), sut.cards.map(\.id))
    }
}
