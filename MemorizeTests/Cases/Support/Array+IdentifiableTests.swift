//
//  Array+IdentifiableTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 30.12.20.
//

@testable import Memorize
import XCTest

class Array_IdentifiableTests: XCTestCase {
    func test_arrayFirstIndexOf_existingElement_returnsIndex() {
        let elementFake = IdentifiableFake()
        let sut = [IdentifiableFake(), elementFake, IdentifiableFake()]
        let expectedIndex = 1

        let index = sut.firstIndex(of: elementFake)

        XCTAssertEqual(expectedIndex, index)
    }

    func test_arrayFirstIndexOf_missingElement_returnsNil() {
        let elementFake = IdentifiableFake()
        let sut = [IdentifiableFake(), IdentifiableFake()]

        let index = sut.firstIndex(of: elementFake)

        XCTAssertNil(index)
    }

    func test_arrayFirstIndexOf_existingElement_returnsFirstIndex() {
        let elementFake = IdentifiableFake()
        let sut = [IdentifiableFake(), elementFake, IdentifiableFake(), elementFake]
        let expectedIndex = 1

        let index = sut.firstIndex(of: elementFake)

        XCTAssertEqual(expectedIndex, index)
    }

    func test_arrayFirstIndexWith_existingElementID_returnsIndex() {
        let elementFake = IdentifiableFake()
        let sut = [IdentifiableFake(), elementFake, IdentifiableFake()]
        let expectedIndex = 1

        let index = sut.firstIndex(with: elementFake.id)

        XCTAssertEqual(expectedIndex, index)
    }

    func test_arrayFirstIndexWith_missingElementID_returnsNil() {
        let elementFake = IdentifiableFake()
        let sut = [IdentifiableFake(), IdentifiableFake()]

        let index = sut.firstIndex(with: elementFake.id)

        XCTAssertNil(index)
    }

    func test_arrayFirstIndexWith_existingElementID_returnsFirstIndex() {
        let elementFake = IdentifiableFake()
        let sut = [IdentifiableFake(), elementFake, IdentifiableFake(), elementFake]
        let expectedIndex = 1

        let index = sut.firstIndex(with: elementFake.id)

        XCTAssertEqual(expectedIndex, index)
    }

    func test_arrayFirstWith_existingElementID_returnsElement() {
        let expectedElement = IdentifiableFake()
        let sut = [IdentifiableFake(), expectedElement, IdentifiableFake()]

        let element = sut.first(with: expectedElement.id)

        XCTAssertEqual(expectedElement.id, element?.id)
    }

    func test_arrayFirstWith_missingElementID_returnsNil() {
        let elementFake = IdentifiableFake()
        let sut = [IdentifiableFake(), IdentifiableFake()]

        let index = sut.first(with: elementFake.id)

        XCTAssertNil(index)
    }
}
