//
//  MemorizeUITests.swift
//  MemorizeUITests
//
//  Created by Martin Hettiger on 26.12.20.
//

import XCTest

class MemorizeUITests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }

    func test_rootViewNewGame_startsNewGameWithDifferentThemeAndShowsCurrentThemeName() throws {
        let app = XCUIApplication()
        app.launch()

        let navigationBar = app.navigationBars
        let newGameButton = navigationBar.buttons["New Game"]
        let navigationTitle = navigationBar.staticTexts
        let initialTheme = navigationTitle.firstMatch.label

        XCTAssertTrue(newGameButton.exists)
        XCTAssertFalse(initialTheme.isEmpty)

        newGameButton.tap()

        XCTAssertNotEqual(initialTheme, navigationTitle.firstMatch.label)
    }
}
