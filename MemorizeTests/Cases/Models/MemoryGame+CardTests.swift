//
//  MemoryGame+CardTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 02.01.21.
//

@testable import Memorize
import XCTest

class MemoryGame_CardTests: XCTestCase {
    typealias ContentType = Character
    typealias Game = MemoryGame<ContentType>

    var sut: Game.Card!
    var timeMachine = TimeMachine.shared

    override func setUpWithError() throws {
        try super.setUpWithError()
        timeMachine.isActive = true
        sut = Game.Card(id: 0, content: "a")
    }

    override func tearDownWithError() throws {
        timeMachine.isActive = false
        sut = nil
        try super.tearDownWithError()
    }

    func assertIsIdentifiable<T: Identifiable>(_: T) {}

    func test_card_isIdentifiable() {
        assertIsIdentifiable(sut)
    }

    func test_card_isHashable() {
        XCTAssertTrue((sut as Any) is AnyHashable)
    }

    func test_card_providesContent() {
        XCTAssertTrue((sut.content as Any) is ContentType)
    }

    func test_card_providesIsFaceUp() {
        XCTAssertTrue((sut.isFaceUp as Any) is Bool)
    }

    func test_card_providesHasBeenFaceUp() {
        XCTAssertTrue((sut.hasBeenFaceUp as Any) is Bool)
    }

    func test_card_providesIsMatched() {
        XCTAssertTrue((sut.isMatched as Any) is Bool)
    }

    func test_cardIsFaceUpSetToFalse_isFaceUp_setsHasBeenFaceUpToTrue() {
        sut = Game.Card(id: 0, content: "a", isFaceUp: true, hasBeenFaceUp: false)

        sut.isFaceUp.toggle()

        XCTAssertFalse(sut.isFaceUp)
        XCTAssertTrue(sut.hasBeenFaceUp)
    }

    func test_cardIsFaceUpSetToTrue_isFaceDownHasBeenFaceUp_hasBeenFaceUpStaysTrue() {
        sut = Game.Card(id: 0, content: "a", isFaceUp: false, hasBeenFaceUp: true)

        sut.isFaceUp.toggle()

        XCTAssertTrue(sut.isFaceUp)
        XCTAssertTrue(sut.hasBeenFaceUp)
    }
}
