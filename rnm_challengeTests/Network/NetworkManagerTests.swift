//
//  NetworkManagerTests.swift
//  rnm_challengeTests
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import XCTest
@testable import rnm_challenge

class NetworkManagerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchingCharacterPage() {
        let expectation = self.expectation(description: "Character page requested")

        NetworkManager.shared.characterService.all(page: 2) { (characters, err) in
            if let characters = characters {
                XCTAssert(characters.count == 20, "There should be 20 characters in 1 page!")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchingMultipleCharacters() {
        let expectation = self.expectation(description: "3 characters requested")

        NetworkManager.shared.characterService.with(ids: [15, 38, 105]) { (characters, err) in
            if let characters = characters {
                XCTAssert(characters.count == 3, "There should be 3 characters returned!!")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchingCharacter() {
        let expectation = self.expectation(description: "Character requested")

        NetworkManager.shared.characterService.with(id: 1) { (character, err) in
            if let rick = character {
                XCTAssertEqual(rick.name, "Rick Sanchez", "The name should be Rick Sanchez!")
                XCTAssertEqual(rick.status, Status.alive, "Rick should be alive!!")
                XCTAssertEqual(rick.species, Species.human, "Rick is a human (actually not but oh well)!")
                XCTAssertEqual(rick.gender, Gender.male, "Rick is a male!")
                XCTAssertEqual(rick.origin.name, "Earth (C-137)", "Rick originates from earth (or does he??)!")
                XCTAssert(rick.location.id == 20, "Location id should be 20!")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchingLocation() {
        let expectation = self.expectation(description: "Location requested")

        NetworkManager.shared.locationService.location(id: 1) { (location, err) in
            if let earth = location {
                XCTAssertEqual(earth.name, "Earth (C-137)", "The name should be Earth!")
                XCTAssertEqual(earth.type, LocationType.planet, "The location type should be Planet!!")
                XCTAssertEqual(earth.residents.count, 27, "There should be 2 residents on Earth!")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
