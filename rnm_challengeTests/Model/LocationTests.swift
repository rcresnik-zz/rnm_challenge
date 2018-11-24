//
//  LocationTests.swift
//  rnm_challengeTests
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import XCTest
@testable import rnm_challenge

class LocationTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocationsDecoding() {
        let path = Bundle(for: type(of: self)).path(forResource: "locations", ofType: "js")!
        let url = URL(fileURLWithPath: path)
        let response = try! Data(contentsOf: url)

        do {
            let networObject = try JSONDecoder().decode(NetworkObject<Location>.self, from: response)
            let locations = networObject.results
            XCTAssertEqual(locations.count, 1, "There should be only 1 character present!")

            let earth = locations[0]
            XCTAssertEqual(earth.name, "Earth", "The name should be Earth!")
            XCTAssertEqual(earth.type, LocationType.planet, "The location type should be Planet!!")
            XCTAssert(earth.residents.count == 2, "There should be 2 residents on Earth!")
        } catch let err as Err {
            XCTFail(err.description)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
