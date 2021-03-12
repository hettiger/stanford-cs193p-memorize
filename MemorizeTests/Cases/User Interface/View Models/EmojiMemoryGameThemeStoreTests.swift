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

    var userDefaults: UserDefaultsFake {
        container.resolve(UserDefaults.self)! as! UserDefaultsFake
    }

    override func setUp() {
        super.setUp()
        container.autoregister(UserDefaults.self, initializer: UserDefaultsFake.init)
            .inObjectScope(.container)
    }

    override func tearDown() {
        container.removeAll()
        super.tearDown()
    }

    func test_emojiMemoryGameThemeStore_providesThemes() {
        XCTAssertTrue((sut.themes as Any) is [Game.Theme])
    }

    func test_emojiMemoryGameThemeStore_persistsThemesToUserDefaults() {
        sut.themes = container.resolve([Game.Theme].self)!

        let json = userDefaults.string(forKey: UserDefaults.Key.themes.rawValue)
        
        XCTAssertNotNil(json)
    }
    
    func test_emojiMemoryGameThemeStore_providesStoredThemes() {
        let expectedThemes = container.resolve([Game.Theme].self)!
        let data = try! JSONEncoder().encode(expectedThemes)
        let json = String(data: data, encoding: .utf8)
        userDefaults.setValue(json, forKey: UserDefaults.Key.themes.rawValue)
        
        let actualThemes = sut.themes
        
        XCTAssert(actualThemes.count == expectedThemes.count)
    }
}
