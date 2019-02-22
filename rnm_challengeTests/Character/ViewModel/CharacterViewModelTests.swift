//
//  CharacterViewModelTests.swift
//  rnm_challengeTests
//
//  Created by rokit on 22/02/2019.
//  Copyright © 2019 rok cresnik. All rights reserved.
//

import XCTest
@testable import rnm_challenge

class CharacterViewModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetup() {
        let path = Bundle(for: type(of: self)).path(forResource: "character", ofType: "js")!
        let url = URL(fileURLWithPath: path)
        let response = try! Data(contentsOf: url)

        do {
            let character = try JSONDecoder().decode(AnimatedCharacter.self, from: response)
            let viewModel = CharacterViewModel(item: character)

            XCTAssertEqual(viewModel.characterName, character.name)
            XCTAssertEqual(viewModel.genderSpecification, character.gender.rawValue)
            XCTAssertEqual(viewModel.originLocation, character.origin.name)
            XCTAssertEqual(viewModel.lastKnownLocation, character.location.name)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
