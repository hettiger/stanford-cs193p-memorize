//
//  MemoryGame+ThemeTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 01.01.21.
//

import GameKit
@testable import Memorize
import SwiftUI
import XCTest

class MemoryGame_ThemeTests: XCTestCase {
    typealias Game = EmojiMemoryGame.Game

    var sut: Game.Theme!
    var contents: String! = "abcd"
    var color: Color! = .red

    override func setUp() {
        super.setUp()
        sut = .init(name: "fake", contents: contents, color: color)
    }

    override func tearDown() {
        sut = nil
        contents = nil
        color = nil
        super.tearDown()
    }

    func test_theme_isHashable() {
        XCTAssertTrue((sut as Any) is AnyHashable)
    }

    func test_theme_providesName() {
        XCTAssertTrue((sut.name as Any) is String)
    }

    func test_theme_providesContents() {
        XCTAssertTrue(sut.contents == Set(contents))
    }

    func test_theme_providesColor() {
        XCTAssertTrue(sut.color == color)
    }

    func test_theme_isCodable() {
        XCTAssert((sut as Any) is Codable)
    }
}
