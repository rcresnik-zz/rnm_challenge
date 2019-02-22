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

        NetworkManager.shared.characterStore.with(page: 2) { (result) in
            switch result {
            case .success(let characters):
                XCTAssert(characters.count == 20, "There should be 20 characters in 1 page!")

            case .failure(let err):
                XCTFail(err.description)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchingMultipleCharacters() {
        let expectation = self.expectation(description: "3 characters requested")

        NetworkManager.shared.characterStore.with(ids: [15, 38, 105]) { (result) in
            switch result {
            case .success(let characters):
                XCTAssert(characters.count == 3, "There should be 3 characters returned!!")
            case .failure(let err):
                XCTFail(err.description)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchingCharacter() {
        let expectation = self.expectation(description: "Character requested")

        NetworkManager.shared.characterStore.with(ids: [1]) { (result) in
            switch result {
            case .success(let characters):
                let rick = characters[0]
                XCTAssertEqual(rick.name, "Rick Sanchez", "The name should be Rick Sanchez!")
                XCTAssertEqual(rick.status, Status.alive, "Rick should be alive!!")
                XCTAssertEqual(rick.species, Species.human, "Rick is a human (actually not but oh well)!")
                XCTAssertEqual(rick.gender, Gender.male, "Rick is a male!")
                XCTAssertEqual(rick.origin.name, "Earth (C-137)", "Rick originates from earth (or does he??)!")
                XCTAssert(rick.location.id == 20, "Location id should be 20!")
            case .failure(let err):
                XCTFail(err.description)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchingLocation() {
        let expectation = self.expectation(description: "Location requested")

        NetworkManager.shared.locationStore.locations(ids: [1]) { (result) in
            switch result {
            case .success(let locations):
                let earth = locations[0]
                XCTAssertEqual(earth.name, "Earth (C-137)", "The name should be Earth!")
                XCTAssertEqual(earth.type, LocationType.planet, "The location type should be Planet!!")
                XCTAssertEqual(earth.residents.count, 27, "There should be 2 residents on Earth!")
            case .failure(let err):
                XCTFail(err.description)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}
