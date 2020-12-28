//
//  EmojiMemoryGameTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 27.12.20.
//

@testable import Memorize
import XCTest

class EmojiMemoryGameTests: XCTestCase {
    var sut: EmojiMemoryGame!
    var randomSourceFake: RandomSourceFake!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = EmojiMemoryGame()
        randomSourceFake = RandomSourceFake()
        sut.randomSource = randomSourceFake
    }

    override func tearDownWithError() throws {
        sut = nil
        randomSourceFake = nil
        try super.tearDownWithError()
    }

    func test_emojiMemoryGame_providesCards() {
        XCTAssertTrue((sut.cards as Any) is [MemoryGame<String>.Card])
    }

    func test_emojiMemoryGame_providesRandomNumberOfPairsOfCardsBetweenTwoAndFivePairs() {
        let lowerBound = 2
        let upperBound = 5
        let nextInt = 2
        randomSourceFake.nextInt = nextInt

        let cards = sut.cards

        XCTAssertEqual(upperBound - lowerBound + 1, randomSourceFake.lastUpperBound)
        XCTAssertEqual(2 * (nextInt + lowerBound), cards.count)
    }

    func test_emojiMemoryGameChoose_isFaceDown_setsIsFaceUpToTrue() {
        sut.choose(card: sut.cards.first!)

        XCTAssertTrue(sut.cards.first!.isFaceUp)
    }

    func test_emojiMemoryGameChoose_isFaceUp_setsIsFaceUpToFalse() {
        sut.choose(card: sut.cards.first!)
        sut.choose(card: sut.cards.first!)

        XCTAssertFalse(sut.cards.first!.isFaceUp)
    }
}
