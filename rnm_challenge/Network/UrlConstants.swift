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
        static func with(ids: [Int]? = nil, page: Int? = nil) -> String? {
            var string: String? = nil
            if let ids = ids {
                let idString = ids.map { "\($0)" }.joined(separator: ",")
                string = UrlConstants.baseUrl + "character/\(idString)"
            } else if let page = page {
                string = UrlConstants.baseUrl + "character/?page=\(page)"
            }

            return string
        }
    }

    struct Location {
        static func with(ids: [Int]) -> String {
            let idString = ids.map { "\($0)" }.joined(separator: ",")
            return UrlConstants.baseUrl + "location/\(idString)"
        }
    }
}
