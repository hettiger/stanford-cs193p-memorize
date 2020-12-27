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

    func test_memoryGame_providesMemoryGameCards() {
        XCTAssertTrue((sut.cards as Any) is [MemoryGame<String>.Card])
    }

    func test_memoryGame_providesPairsOfMemoryGameCards() {
        let expectedNumberOfPairsOfCards = contents.count * 2

        let actualNumberOfPairsOfCards = sut.cards.count

        XCTAssertGreaterThan(expectedNumberOfPairsOfCards, 1)
        XCTAssertEqual(expectedNumberOfPairsOfCards, actualNumberOfPairsOfCards)
    }

    func test_memoryGameChoose_isFaceDown_setsIsFaceUpToTrue() {
        sut.choose(card: sut.cards.first!)

        XCTAssertTrue(sut.cards.first!.isFaceUp)
    }

    func test_memoryGameChoose_isFaceUp_setsIsFaceUpToFalse() {
        sut.choose(card: sut.cards.first!)
        sut.choose(card: sut.cards.first!)

        XCTAssertFalse(sut.cards.first!.isFaceUp)
    }
}
