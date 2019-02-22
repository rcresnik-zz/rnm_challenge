//
//  LocastionViewTests.swift
//  rnm_challengeTests
//
//  Created by rokit on 22/02/2019.
//  Copyright © 2019 rok cresnik. All rights reserved.
//

import XCTest
@testable import rnm_challenge

class LocastionViewTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetup() {
        let path = Bundle(for: type(of: self)).path(forResource: "locations", ofType: "js")!
        let url = URL(fileURLWithPath: path)
        let response = try! Data(contentsOf: url)

        do {
            let networObject = try JSONDecoder().decode(NetworkObject<Location>.self, from: response)
            let location = networObject.results[0]
            let viewModel = LocationViewModel(item: location)

            let view: LocationView = UIView.loadView(identifier: LocationView.identifier)
            view.setup(viewModel: viewModel)

            XCTAssertEqual(view.nameLabel.text, location.name)
            XCTAssertEqual(view.dimensionLabel.text, location.dimension)
            XCTAssertEqual(view.typeLabel.text, location.type.rawValue)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
