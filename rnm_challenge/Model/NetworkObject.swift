//
//  List.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

struct NetworkObject<T: Decodable> {
    let info: Info
    let results: [T]
}

extension NetworkObject: Decodable {
    private enum PropertyKeys: String, CodingKey {
        case info
        case results
    }

    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: PropertyKeys.self)

            self.info = try container.decode(Info.self, forKey: .info)
            self.results = try container.decode([T].self, forKey: .results)
        } catch {
            throw Err(sender: NetworkObject.self, error: error)
        }
    }
}
