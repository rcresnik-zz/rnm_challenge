//
//  CharacterTests.swift
//  rnm_challengeTests
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import XCTest
@testable import rnm_challenge

class CharacterTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCharacterDecoding() {
        let path = Bundle(for: type(of: self)).path(forResource: "character", ofType: "js")!
        let url = URL(fileURLWithPath: path)
        let response = try! Data(contentsOf: url)

        do {
            let morty = try JSONDecoder().decode(AinmatedCharacter.self, from: response)

            XCTAssertEqual(morty.name, "Morty Smith", "The name should be Morty Smith!")
            XCTAssertEqual(morty.status, Status.alive, "Morty should be alive!!")
            XCTAssertEqual(morty.species, Species.human, "Morty is a human!")
            XCTAssertEqual(morty.gender, Gender.male, "Morty is a male!")
            XCTAssertEqual(morty.origin.name, "Earth", "Morty originates from earth!")
        } catch let err as Err {
            XCTFail(err.description)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testCharactersDecoding() {
        let path = Bundle(for: type(of: self)).path(forResource: "characters", ofType: "js")!
        let url = URL(fileURLWithPath: path)
        let response = try! Data(contentsOf: url)

        do {
            let networObject = try JSONDecoder().decode(NetworkObject<AinmatedCharacter>.self, from: response)
            let characters = networObject.results
            XCTAssertEqual(characters.count, 1, "There should be only 1 character present!")
            
            let rick = characters[0]
            XCTAssertEqual(rick.name, "Rick Sanchez", "The name should be Rick Sanchez!")
            XCTAssertEqual(rick.status, Status.alive, "Rick should be alive!!")
            XCTAssertEqual(rick.species, Species.human, "Rick is a human (actually not but oh well)!")
            XCTAssertEqual(rick.gender, Gender.male, "Rick is a male!")
            XCTAssertEqual(rick.origin.name, "Earth", "Rick originates from earth (or does he??)!")
        } catch let err as Err {
            XCTFail(err.description)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
