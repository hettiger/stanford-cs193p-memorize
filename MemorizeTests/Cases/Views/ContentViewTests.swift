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
    var sut: ContentView!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ContentView()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_contentView_showsCorrectNumberOfCardViews() throws {
        let expectedNumberOfCardViews = sut.game.cards.count

        let actualNumberOfCardViews = try sut.inspect().findAll(CardView.self).count

        XCTAssertEqual(expectedNumberOfCardViews, actualNumberOfCardViews)
    }

    func test_contentView_onCardViewTap_choosesCard() throws {
        try sut.inspect().find(CardView.self).callOnTapGesture()

        XCTAssertTrue(sut.game.cards.first!.isFaceUp)
    }

    func test_contentView_cardsHaveAccessibilityIdentifier() throws {
        let expectedAccessibilityIdentifier = "Memory Game Card \(sut.game.cards[0].id)"

        let accessibilityIdentifier = try sut.inspect().find(CardView.self)
            .accessibilityIdentifier()
        
        XCTAssertEqual(expectedAccessibilityIdentifier, accessibilityIdentifier)
    }
}
