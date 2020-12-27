//
//  MemoryGameTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 27.12.20.
//

@testable import Memorize
import XCTest

class MemoryGameTests: XCTestCase {
    var sut: MemoryGame<String>!
    var contents: String!

    override func setUpWithError() throws {
        try super.setUpWithError()
        withContents("🐶🐱🐭🐰")
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func withContents(_ newContents: String) {
        contents = newContents
        sut = MemoryGame<String>(numberOfPairsOfCards: contents.count) { pairIndex in
            contents[pairIndex]
        }
    }

    func test_memoryGame_providesCards() {
        XCTAssertNotNil(sut.cards)
        XCTAssertTrue((sut.cards as Any) is [MemoryGame<String>.Card])
    }

    func test_memoryGame_contents_providesPairsOfCardsWithContents() {
        let expectedNumberOfPairsOfCards = contents.count * 2

        let actualNumberOfPairsOfCards = sut.cards.count

        XCTAssertEqual(expectedNumberOfPairsOfCards, actualNumberOfPairsOfCards)
    }

    func test_memoryGame_whenFaceDownCardIsChosen_cardIsFaceUp() {
        XCTAssertFalse(sut.cards.first!.isFaceUp)

        sut.choose(card: sut.cards.first!)

        XCTAssertTrue(sut.cards.first!.isFaceUp)
    }

    func test_memoryGame_whenFaceUpCardIsChosen_cardIsFaceUp() {
        sut.choose(card: sut.cards.first!)

        XCTAssertTrue(sut.cards.first!.isFaceUp)

        sut.choose(card: sut.cards.first!)

        XCTAssertFalse(sut.cards.first!.isFaceUp)
    }

    func test_game_providesIdentifiableCards() {
        withContents("🐶")

        let cardA = sut.cards.first!
        let cardB = sut.cards.last!

        XCTAssertEqual(0, cardA.id)
        XCTAssertEqual(1, cardB.id)
    }
    
    func test_card_providesContent() {
        let card = sut.cards.first!
        let expectedContent = contents[0]

        let actualContent = card.content

        XCTAssertEqual(expectedContent, actualContent)
    }
}
