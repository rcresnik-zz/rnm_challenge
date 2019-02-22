//
//  rnm_challengeUITests.swift
//  rnm_challengeUITests
//
//  Created by rokit on 22/02/2019.
//  Copyright © 2019 rok cresnik. All rights reserved.
//

import XCTest

class rnm_challengeUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launchArguments.append("uitesting")
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddFavorites() {
        let name = "Morty Smith"

        app.tables.staticTexts[name].tap()

        app.buttons["Add to favorites"].tap()
        sleep(1)
        app.tabBars.buttons["Favorites"].tap()
        sleep(2)

        XCTAssertTrue(app.tables.staticTexts[name].exists,
                      "There should be a favorite character with \(name).")
    }

    func testRemoveFavorites() {
        let name = "Summer Smith"

        app.tables.staticTexts[name].tap()

        app.buttons["Add to favorites"].tap()
        app.tabBars.buttons["Favorites"].tap()
        sleep(1)

        app.tables.staticTexts[name].tap()

        app.buttons["Remove from favorites"].tap()
        app.navigationBars["Details"].buttons["Favorite characters"].tap()

        XCTAssertFalse(app.tables.staticTexts[name].exists,
                      "There shouldn't be a favorite character with \(name).")
    }
}
