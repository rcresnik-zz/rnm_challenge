//
//  LocalStorageTests.swift
//  rnm_challengeTests
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import XCTest
@testable import rnm_challenge

class LocalStorageTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        LocalStorage.removeAllFavorites()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddingToStorage() {
        LocalStorage.addFavorite(id: 5)
        XCTAssert(LocalStorage.favorites().count == 1, "there should be 1 element in favorites!")

        LocalStorage.addFavorite(id: 6)
        LocalStorage.addFavorite(id: 5)
        XCTAssert(LocalStorage.favorites().count == 2, "there should be 2 element in favorites!")

        LocalStorage.toggleFavorite(id: 6)
        XCTAssert(LocalStorage.favorites().count == 1, "there should be 1 element in favorites!")
        
        LocalStorage.addFavorite(id: 15)
        LocalStorage.addFavorite(id: 45)
        LocalStorage.removeFavorite(id: 45)
        LocalStorage.removeFavorite(id: 45)
        XCTAssert(LocalStorage.favorites().count == 2, "there should be 1 element in favorites!")
    }
}
