//
//  API.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

struct UrlConstants {
    static let baseUrl = "https://rickandmortyapi.com/api/"
    struct Character {
        static func all(page: Int) -> String {
            return UrlConstants.baseUrl + "character/?page=\(page)"
        }
        static func with(id: Int) -> String {
            return UrlConstants.baseUrl + "/\(id)"
        }
    }

    struct Location {

    }
}
