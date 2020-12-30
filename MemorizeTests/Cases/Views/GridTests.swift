//
//  GridTests.swift
//  MemorizeTests
//
//  Created by Martin Hettiger on 30.12.20.
//

@testable import Memorize
import SwiftUI
import ViewInspector
import XCTest

extension Grid: Inspectable {}
extension Rectangle: Inspectable {}

class GridTests: XCTestCase {
    func test_grid_drawsOneItemViewForEachProvidedItem() throws {
        let expectedNumberOfItemViews = 5
        let items = Array(0 ..< expectedNumberOfItemViews).map { _ in ItemFake() }
        let sut = Grid(items) { _ in Rectangle() }

        let numberOfItemViews = try! sut.inspect().findAll(Rectangle.self).count

        XCTAssertEqual(expectedNumberOfItemViews, numberOfItemViews)
    }
}
