//
//  LocationTests.swift
//  rnm_challengeUITests
//
//  Created by rokit on 22/02/2019.
//  Copyright © 2019 rok cresnik. All rights reserved.
//

import XCTest

class LocationTests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launchArguments.append("uitesting")
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOrigin() {
        let name = "Jerry Smith"

        app.tables.staticTexts[name].tap()
        sleep(1)

        let locationTitle = "Earth (Replacement Dimension)"
        app.staticTexts[locationTitle].firstMatch.tap()

        XCTAssertTrue(app.staticTexts[locationTitle].exists, "We should be on the \(locationTitle) screen.")

        app.staticTexts["105 residents"].tap()
        sleep(1)

        XCTAssertTrue(app.tables.staticTexts[name].exists, "\(name) should exist.")
    }

    func testLastLocation() {
        let name = "Adjudicator Rick"

        app.swipeUp()
        app.tables.staticTexts[name].firstMatch.tap()
        sleep(1)

        let locationTitle = "Citadel of Ricks"
        app.staticTexts[locationTitle].tap()

        XCTAssertTrue(app.staticTexts[locationTitle].exists, "We should be on the \(locationTitle) screen.")

        app.staticTexts["91 residents"].tap()
        sleep(1)

        XCTAssertTrue(app.tables.staticTexts[name].exists, "\(name) should exist.")
    }
}
