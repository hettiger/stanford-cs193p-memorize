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

    func test_memoryGameCard_providesContent() {
        XCTAssertEqual(content, sut.content)
    }
    
    func test_memoryGameCard_providesIsFaceUp() {
        let expectedIsFaceUp = true
        
        sut.isFaceUp = expectedIsFaceUp
        
        XCTAssertEqual(expectedIsFaceUp, sut.isFaceUp)
    }
}
