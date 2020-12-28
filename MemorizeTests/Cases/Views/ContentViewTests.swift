//
//  ContentViewTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 27.12.20.
//

@testable import Memorize
import SwiftUI
import ViewInspector
import XCTest

extension ContentView: Inspectable {}

class ContentViewTests: XCTestCase {
    var gameFake: EmojiMemoryGameFake!

    override func setUpWithError() throws {
        try super.setUpWithError()
        gameFake = EmojiMemoryGameFake()
    }

    override func tearDownWithError() throws {
        gameFake = nil
        try super.tearDownWithError()
    }

    func withNumberOfPairsOfCards(_ numberOfPairsOfCards: Int) {
        let numberOfCards = 2 * numberOfPairsOfCards
        gameFake.cards = Array(0 ..< numberOfCards).map { .init(id: $0, content: "\($0)") }
    }

    func test_contentView_showsCardViews() throws {
        let sut = ContentView()

        for element in try sut.inspect().hStack().forEach(0) {
            let cardView = try? element.view(CardView.self)
            XCTAssertNotNil(cardView)
        }
    }

    func test_contentView_showsCorrectNumberOfCardViews() throws {
        let sut = ContentView()
        let expectedNumberOfCardViews = sut.game.cards.count

        let actualNumberOfCardViews = try sut.inspect().hStack().forEach(0).count

        XCTAssertEqual(expectedNumberOfCardViews, actualNumberOfCardViews)
    }

    func test_contentView_onCardViewTap_choosesCard() throws {
        let sut = ContentView()

        try sut.inspect().hStack().forEach(0).first!.callOnTapGesture()

        XCTAssertTrue(sut.game.cards.first!.isFaceUp)
    }

    func test_contentView_twoToFourPairsOfCards_usesLargeTitleFont() throws {
        let expectedFont = Font.largeTitle
        var sut = ContentView()
        sut.game = gameFake

        for numberOfPairsOfCards in 2 ... 4 {
            withNumberOfPairsOfCards(numberOfPairsOfCards)

            let font = try sut.inspect().hStack().font()

            XCTAssertEqual(expectedFont, font)
        }
    }

    func test_contentView_fivePairsOfCards_usesBodyFont() throws {
        let expectedFont = Font.body
        var sut = ContentView()
        sut.game = gameFake
        withNumberOfPairsOfCards(5)

        let font = try sut.inspect().hStack().font()

        XCTAssertEqual(expectedFont, font)
    }
}
