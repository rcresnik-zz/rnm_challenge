//
//  Location.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

struct Location {
    let name: String
    let url: URL?
}

extension Location: Decodable {
    private enum PropertyKeys: String, CodingKey {
        case name
        case url
    }

    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: PropertyKeys.self)

            let name = try container.decode(String.self, forKey: .name)
            let url = URL(string: try container.decode(String.self, forKey: .url))

            self.init(name: name, url: url)
        } catch {
            throw Err(sender: Location.self, error: error)
        }
    }
}
