//
//  Array+shuffleTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 28.12.20.
//

@testable import Memorize
import XCTest

class Array_shuffleTests: XCTestCase {
    var randomSourceFake: RandomSourceFake!

    override func setUpWithError() throws {
        try super.setUpWithError()
        randomSourceFake = RandomSourceFake()
    }

    override func tearDownWithError() throws {
        randomSourceFake = nil
        try super.tearDownWithError()
    }

    func test_arrayShuffle_shufflesArrayInPlace() {
        let expectedArray = ["b", "a"]
        randomSourceFake.shuffle = { _ in expectedArray }
        var array = ["a", "b"]

        array.shuffle(using: randomSourceFake)

        XCTAssertEqual(expectedArray, array)
    }

    func test_arrayShuffled_returnsShuffledArray() {
        let expectedArray = ["b", "a"]
        randomSourceFake.shuffle = { _ in expectedArray }
        var array = ["a", "b"]

        array = array.shuffled(using: randomSourceFake)

        XCTAssertEqual(expectedArray, array)
    }
}
