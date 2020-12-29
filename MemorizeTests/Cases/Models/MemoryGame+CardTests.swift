//
//  MemoryGame+CardTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 27.12.20.
//

@testable import Memorize
import XCTest

class MemoryGame_CardTests: XCTestCase {
    var sut: MemoryGame<String>.Card!
    var id: Int!
    var content: String!

    override func setUpWithError() throws {
        try super.setUpWithError()
        id = 1
        content = "content"
        sut = MemoryGame<String>.Card(id: id, content: content)
    }

    override func tearDownWithError() throws {
        id = nil
        content = nil
        sut = nil
        try super.tearDownWithError()
    }

    func assertIsIdentifiable<T: Identifiable>(object _: T) where T.ID: Any {}

    func test_memoryGameCard_isIdentifiable() {
        assertIsIdentifiable(object: sut)
    }

    func test_memoryGameCard_providesContent() {
        XCTAssertEqual(content, sut.content)
    }

    func test_memoryGameCardChoose_isFaceDown_setsIsFaceUpToTrue() {
        sut.choose()

        XCTAssertTrue(sut.isFaceUp)
    }

    func test_memoryGameCardChoose_isFaceUp_setsIsFaceUpToFalse() {
        sut.choose()
        sut.choose()

        XCTAssertFalse(sut.isFaceUp)
    }

    func test_memoryGameCard_isHashable() {
        XCTAssertTrue((sut as Any) is AnyHashable)
    }
}
