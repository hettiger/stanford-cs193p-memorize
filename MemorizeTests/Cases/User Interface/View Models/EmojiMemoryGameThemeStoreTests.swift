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

    func test_emojiMemoryGameThemeStore_isObservableObject() {
        func assertIsObservableObject<T: ObservableObject>(_: T)
            where T.ObjectWillChangePublisher: Any {}
        assertIsObservableObject(sut)
    }

    func test_emojiMemoryGameThemeStore_providesThemes() {
        XCTAssertTrue((sut.themes as Any) is [Game.Theme])
    }

    func test_emojiMemoryGameThemeStore_providesThemesPublisher() {
        XCTAssertTrue((sut.$themes as Any) is Published<[Game.Theme]>.Publisher)
    }

    func test_emojiMemoryGameThemeStore_seedsInitialData() {
        let expectedThemes = container.resolve([Game.Theme].self)!

        let actualThemes = sut.themes

        XCTAssert(actualThemes.count == expectedThemes.count)
    }

    func test_emojiMemoryGameThemeStore_withDidSeedThemesSetToTrue_doesNotSeedData() {
        userDefaults.setValue(true, forKey: UserDefaults.Key.didSeedThemes.rawValue)

        let actualThemes = sut.themes

        XCTAssert(actualThemes.count == 0)
    }

    func test_emojiMemoryGameThemeStore_persistsThemesToUserDefaults() {
        sut.themes = [.init(name: "fake theme", contents: "")]

        let json = userDefaults.string(forKey: UserDefaults.Key.themes.rawValue)

        XCTAssertTrue(json?.contains("fake theme") ?? false)
    }

    func test_emojiMemoryGameThemeStore_providesStoredThemes() {
        let expectedThemes = [Game.Theme(name: "fake theme", contents: "")]
        let data = try! JSONEncoder().encode(expectedThemes)
        let json = String(data: data, encoding: .utf8)
        userDefaults.setValue(json, forKey: UserDefaults.Key.themes.rawValue)

        let actualThemes = sut.themes

        XCTAssert(actualThemes.map(\.name) == ["fake theme"])
    }
}
