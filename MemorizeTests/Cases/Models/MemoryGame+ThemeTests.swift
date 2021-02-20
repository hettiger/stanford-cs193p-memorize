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
    var numberOfPairsOfCards: Int!
    var randomSourceFake: RandomSourceFake!

    override func setUpWithError() throws {
        try super.setUpWithError()
        numberOfPairsOfCards = 4
        randomSourceFake = RandomSourceFake()
        withContents("abcdefg")
    }

    override func tearDownWithError() throws {
        sut = nil
        contents = nil
        numberOfPairsOfCards = nil
        randomSourceFake = nil
        try super.tearDownWithError()
    }

    func withContents(_ contents: String) {
        self.contents = .init(contents)
        sut = .init(
            name: themeName,
            contents: contents,
            numberOfPairsOfCards: numberOfPairsOfCards,
            color: color,
            randomSource: randomSourceFake
        )
    }

    func withNumberOfPairsOfCards(_ numberOfPairsOfCards: Int) {
        self.numberOfPairsOfCards = numberOfPairsOfCards
        sut = .init(
            name: themeName,
            contents: contents,
            numberOfPairsOfCards: numberOfPairsOfCards,
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

    func test_theme_numberOfPairsOfCards_cardsCountIsDoubleTheNumberOfPairsOfCards() {
        withNumberOfPairsOfCards(4)

        XCTAssertEqual(8, sut.cards.count)
    }

    func test_theme_negativeNumberOfPairsOfCards_cardsCountIsZero() {
        withNumberOfPairsOfCards(-10)

        XCTAssertEqual(0, sut.cards.count)
    }

    func test_theme_zeroNumberOfPairsOfCards_cardsCountIsZero() {
        withNumberOfPairsOfCards(0)

        XCTAssertEqual(0, sut.cards.count)
    }

    func test_theme_lessContentThanRequestedNumberOfPairsOfCards_cardsCountIsContentElementCountTimesTwo(
    ) {
        withNumberOfPairsOfCards(10)
        withContents("ab")

        XCTAssertEqual(4, sut.cards.count)
    }

    func test_theme_emptyContentButNumberOfPairsOfCardsGreaterThanZero_cardsCountIsZero() {
        withNumberOfPairsOfCards(10)
        withContents("")

        XCTAssertEqual(0, sut.cards.count)
    }

    func test_themeCards_returnsShuffledCards() {
        let expectedCards = "dbca".cards
        randomSourceFake.shuffle = { _ in expectedCards }

        withContents("")

        XCTAssertEqual(expectedCards, sut.cards)
    }
    
    func test_theme_isCodable() {
        XCTAssert((sut as Any) is Codable)
    }
    
    func test_themeJson_returnsString() {
        XCTAssertNotNil(sut.json)
        XCTAssert((sut.json as Any) is String)
    }
}
