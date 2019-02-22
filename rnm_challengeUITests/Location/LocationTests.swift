//
//  LocationTests.swift
//  rnm_challengeUITests
//
//  Created by rokit on 22/02/2019.
//  Copyright © 2019 rok cresnik. All rights reserved.
//

import XCTest

class LocationTests: XCTestCase {

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

    func testOrigin() {
        let name = "Jerry Smith"

        let app = XCUIApplication()

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

        let app = XCUIApplication()
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
