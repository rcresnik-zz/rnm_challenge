//
//  LocationViewControllerTests.swift
//  rnm_challengeTests
//
//  Created by rokit on 22/02/2019.
//  Copyright © 2019 rok cresnik. All rights reserved.
//

import XCTest
@testable import rnm_challenge

class LocationViewControllerTests: XCTestCase {
    var location: Location {
        let path = Bundle(for: type(of: self)).path(forResource: "locations", ofType: "js")!
        let url = URL(fileURLWithPath: path)
        let response = try! Data(contentsOf: url)
        let networObject = try! JSONDecoder().decode(NetworkObject<Location>.self, from: response)

        return networObject.results[0]
    }

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetup() {
        let viewModel = LocationViewModel(item: location)

        let vc: LocationViewController = UIStoryboard.loadViewController()
        vc.locationView.setup(viewModel: viewModel, viewController: vc)

        XCTAssertTrue(vc.responds(to: #selector(LocationProtocol.residentsTapped)))
    }
}
