//
//  MemoryGame+StateTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 30.12.20.
//

@testable import Memorize
import XCTest

class MemoryGame_StateTests: XCTestCase {
    var sut: MemoryGame<Character>.State!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = .noCardFaceUp
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_stateShowsMatch_noCardFaceUp_returnsFalse() {
        XCTAssertFalse(sut.showsMatch(in: "aabb".cards))
    }

    func test_stateShowsMatch_oneCardFaceUp_returnsFalse() {
        let cards = "aabb".cards
        sut = .oneCardFaceUp(cards[0].id)

        XCTAssertFalse(sut.showsMatch(in: cards))
    }

    func test_stateShowsMatchWithMatchingCardsFaceUp_twoCardsFaceUp_returnsTrue() {
        let cards = "aabb".cards
        sut = .twoCardsFaceUp(cards[0].id, cards[1].id)

        XCTAssertTrue(sut.showsMatch(in: cards))
    }

    func test_stateShowsMatchWithNonMatchingCardsFaceUp_twoCardsFaceUp_returnsFalse() {
        let cards = "abab".cards
        sut = .twoCardsFaceUp(cards[0].id, cards[1].id)

        XCTAssertFalse(sut.showsMatch(in: cards))
    }
}
