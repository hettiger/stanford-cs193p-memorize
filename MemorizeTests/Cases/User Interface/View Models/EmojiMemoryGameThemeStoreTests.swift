//
//  EmojiMemoryGameThemeStoreTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 09.03.21.
//

@testable import Memorize
import XCTest

class EmojiMemoryGameThemeStoreTests: XCTestCase {
    typealias Game = EmojiMemoryGame.Game

    let container = ContainerFactory.makeEmojiMemoryGameContainer()

    var sut: EmojiMemoryGameThemeStore {
        container.resolve(EmojiMemoryGameThemeStore.self)!
    }

    override func tearDown() {
        container.removeAll()
        super.tearDown()
    }

    func test_emojiMemoryGameThemeStore_providesThemes() {
        XCTAssertTrue((sut.theme as Any) is [Game.Theme])
    }
}
