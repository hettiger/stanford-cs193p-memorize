//
//  MemoryGame+ThemeTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 01.01.21.
//

import GameKit
@testable import Memorize
import SwiftUI
import XCTest

class MemoryGame_ThemeTests: XCTestCase {
    typealias ContentType = Character
    typealias Game = MemoryGame<ContentType>

    let themeName = "name"
    let color = Color.clear

    var sut: MemoryGame<Character>.Theme!
    var contents: Set<ContentType>!
    var numberOfCards: Int?
    var randomSourceFake: RandomSourceFake!

    override func setUpWithError() throws {
        try super.setUpWithError()
        numberOfCards = nil
        randomSourceFake = RandomSourceFake()
        withContents("abcdefg")
    }

    override func tearDownWithError() throws {
        sut = nil
        contents = nil
        numberOfCards = nil
        randomSourceFake = nil
        try super.tearDownWithError()
    }

    func withContents(_ contents: String) {
        self.contents = .init(contents)
        sut = .init(
            name: themeName,
            contents: contents,
            numberOfCards: numberOfCards,
            color: color,
            randomSource: randomSourceFake
        )
    }

    func withNumberOfCards(_ numberOfCards: Int?) {
        self.numberOfCards = numberOfCards
        sut = .init(
            name: themeName,
            contents: contents,
            numberOfCards: numberOfCards,
            color: color,
            randomSource: randomSourceFake
        )
    }

    func test_theme_isHashable() {
        XCTAssertTrue((sut as Any) is AnyHashable)
    }

    func test_theme_providesName() {
        XCTAssertTrue((sut.name as Any) is String)
    }

    func test_theme_providesCards() {
        XCTAssertTrue((sut.cards as Any) is [Game.Card])
    }

    func test_theme_providesColor() {
        XCTAssertTrue((sut.color as Any) is Color)
    }

    func test_theme_evenNumberOfCards_cardsCountIsMatchingNumbersOfCards() {
        withNumberOfCards(4)

        XCTAssertEqual(4, sut.cards.count)
    }

    func test_theme_unevenNumberOfCards_cardsCountIsNearestEvenNumberInNumberOfCards(
    ) {
        withNumberOfCards(5)

        XCTAssertEqual(4, sut.cards.count)
    }

    func test_theme_negativeNumberOfCards_cardsCountIsZero() {
        withNumberOfCards(-10)

        XCTAssertEqual(0, sut.cards.count)
    }

    func test_theme_zeroNumberOfCards_cardsCountIsZero() {
        withNumberOfCards(0)

        XCTAssertEqual(0, sut.cards.count)
    }

    func test_theme_nilNumberOfCards_cardsCountIsRandom() {
        let lowerBound = 2
        let nextInt = 4
        let expectedCardsCount = 2 * (nextInt + lowerBound)
        randomSourceFake.nextInt = nextInt

        withNumberOfCards(nil)

        XCTAssertEqual(expectedCardsCount, sut.cards.count)
    }

    func test_theme_nilNumberOfCards_randomSourceUsesAppropriateUppderBound() {
        withNumberOfCards(nil)

        for contents in ["", "a", "ab", "abc", "abcd"] {
            let lowerBound = min(2, contents.count)
            let upperBound = contents.count

            withContents(contents)

            XCTAssertEqual(upperBound + 1 - lowerBound, randomSourceFake.lastUpperBound)
        }
    }

    func test_theme_lessContentThanRequestedNumberOfCards_cardsCountIsContentElementCountTimesTwo() {
        withNumberOfCards(10)
        withContents("ab")

        XCTAssertEqual(4, sut.cards.count)
    }

    func test_theme_emptyContentButNumberOfCards_cardsCountIsZero() {
        withNumberOfCards(10)
        withContents("")

        XCTAssertEqual(0, sut.cards.count)
    }

    func test_themeCards_returnsShuffledCards() {
        let expectedCards = "dbca".cards
        randomSourceFake.shuffle = { _ in expectedCards }

        withContents("")

        XCTAssertEqual(expectedCards, sut.cards)
    }
}
