//
//  rnm_challengeUITests.swift
//  rnm_challengeUITests
//
//  Created by rokit on 22/02/2019.
//  Copyright © 2019 rok cresnik. All rights reserved.
//

import XCTest

class rnm_challengeUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddFavorites() {
        let name = "Morty Smith"
        let app = XCUIApplication()
        app.launchArguments.append("uitesting")

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
        let app = XCUIApplication()

        app.tables.staticTexts[name].tap()

        app.buttons["Add to favorites"].tap()
        app.tabBars.buttons["Favorites"].tap()
        sleep(1)

        app.tables.staticTexts[name].tap()

        app.buttons["Remove from favorites"].tap()
        app.navigationBars["Details"].buttons["Favorite characters"].tap()
        sleep(2)

        XCTAssertFalse(app.tables.staticTexts[name].exists,
                      "There shouldn't be a favorite character with \(name).")
    }
}
