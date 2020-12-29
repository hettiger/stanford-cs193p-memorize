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
        randomSourceFake = RandomSourceFake()
        sut = EmojiMemoryGame(randomSource: randomSourceFake)
    }

    override func tearDownWithError() throws {
        randomSourceFake = nil
        sut = nil
        try super.tearDownWithError()
    }

    func withRandom(shuffle: (([Any]) -> [Any])? = nil, nextInt: Int? = nil) {
        randomSourceFake.shuffle = shuffle ?? randomSourceFake.shuffle
        randomSourceFake.nextInt = nextInt ?? randomSourceFake.nextInt
        sut = EmojiMemoryGame(randomSource: randomSourceFake)
    }

    func test_emojiMemoryGame_providesCards() {
        XCTAssertTrue((sut.cards as Any) is [MemoryGame<String>.Card])
    }

    func test_emojiMemoryGame_shufflesEmojis() {
        let expectedEmojis = Array("🐶🐱")
        withRandom(shuffle: { _ in expectedEmojis }, nextInt: 0)

        let cards = sut.cards

        for card in cards {
            XCTAssertTrue(expectedEmojis.contains(card.content.first!))
        }
    }

    func test_emojiMemoryGame_providesRandomNumberOfPairsOfCardsBetweenTwoAndFivePairs() {
        let lowerBound = 2
        let upperBound = 5
        let nextInt = 2
        withRandom(nextInt: nextInt)

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
