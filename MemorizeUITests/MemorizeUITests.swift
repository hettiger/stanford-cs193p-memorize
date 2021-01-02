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

        let navigationBar = app.navigationBars.firstMatch
        let toolBar = app.toolbars.firstMatch
        let newGameButton = toolBar.buttons["New Game"].firstMatch
        let navigationTitle = navigationBar.staticTexts.firstMatch
        let initialTheme = navigationTitle.label

        XCTAssertTrue(newGameButton.exists)
        XCTAssertFalse(initialTheme.isEmpty)

        newGameButton.tap()

        XCTAssertNotEqual(initialTheme, navigationTitle.label)
    }

    func test_rootView_showsCurrentScoreAndHighscore() throws {
        let app = XCUIApplication()
        app.launchArguments.append(CommandLine.Argument.resetUserDefaults.rawValue)
        app.launch()

        XCTAssertTrue(app.staticTexts["Score: 0"].exists)

        app.otherElements["Memory Game Card 0"].tap()
        app.otherElements["Memory Game Card 1"].tap()

        XCTAssertTrue(app.staticTexts["Score: 2"].exists)
        XCTAssertTrue(app.staticTexts["Highscore: 2"].exists)
    }
}
