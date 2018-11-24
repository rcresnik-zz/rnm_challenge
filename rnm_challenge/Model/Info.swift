//
//  Info.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

struct Info {
    let count: Int
    let pages: Int
    let nextUrl: URL?
    let prevUrl: URL?
}

extension Info: Decodable {
    private enum PropertyKeys: String, CodingKey {
        case count
        case pages
        case nextUrl = "next"
        case prevUrl = "prev"
    }

    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: PropertyKeys.self)

            let count = try container.decode(Int.self, forKey: .count)
            let pages = try container.decode(Int.self, forKey: .pages)
            let nextUrl = URL(string: try container.decode(String.self, forKey: .nextUrl))
            let prevUrl = URL(string: try container.decode(String.self, forKey: .prevUrl))

            self.init(count: count,
                      pages: pages,
                      nextUrl: nextUrl,
                      prevUrl: prevUrl)
        } catch {
            throw Err(sender: Info.self, error: error)
        }
    }
}
