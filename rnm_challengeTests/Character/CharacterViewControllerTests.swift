//
//  CharacterViewControllerTests.swift
//  rnm_challengeTests
//
//  Created by rokit on 22/02/2019.
//  Copyright © 2019 rok cresnik. All rights reserved.
//

import XCTest
@testable import rnm_challenge

class CharacterViewControllerTests: XCTestCase {
    var character: AnimatedCharacter {
        let path = Bundle(for: type(of: self)).path(forResource: "character", ofType: "js")!
        let url = URL(fileURLWithPath: path)
        let response = try! Data(contentsOf: url)

        return try! JSONDecoder().decode(AnimatedCharacter.self, from: response)
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetup() {
        let viewModel = CharacterViewModel(item: character)

        let vc: CharacterViewController = UIStoryboard.loadViewController()
        vc.characterView.setup(viewModel: viewModel, viewController: vc)

        XCTAssertTrue(vc.responds(to: #selector(CharacterProtocol.favoriteTapped)))
    }
}
