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

    func test_memoryGame_shufflesCards() {
        let expectedCards = [
            MemoryGame<String>.Card(id: 2, content: "b"),
            MemoryGame<String>.Card(id: 1, content: "a"),
        ]
        randomSourceFake.shuffle = { _ in expectedCards }

        withContents("ab")
        
        XCTAssertEqual(expectedCards, sut.cards)
    }
}
