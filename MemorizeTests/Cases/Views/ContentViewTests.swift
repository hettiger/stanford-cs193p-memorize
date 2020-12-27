//
//  ContentViewTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 27.12.20.
//

@testable import Memorize
import ViewInspector
import XCTest

extension ContentView: Inspectable {}

class ContentViewTests: XCTestCase {
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
}
