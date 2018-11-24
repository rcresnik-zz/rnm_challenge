//
//  Location.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

enum LocationType: String {
    case planet
    case spaceStation = "Space station"
    case unknown
}

struct Location {
    let id: Int?
    let name: String
    let type: LocationType
    let dimension: String
    let residents: [String]
}

extension Location: Decodable {
    private enum PropertyKeys: String, CodingKey {
        case id
        case url
        case name
        case type
        case dimension
        case residents
    }

    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: PropertyKeys.self)

            let urlString = try container.decode(String.self, forKey: .url)
            var id = Int(urlString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
            if  id == nil {
                id = try container.decodeIfPresent(Int.self, forKey: .id)
            }
            let name = try container.decode(String.self, forKey: .name)

            let tmp = try container.decodeIfPresent(String.self, forKey: .type)
            let type = LocationType(rawValue: tmp?.lowercased() ?? "") ?? .unknown

            let dimension = try container.decodeIfPresent(String.self, forKey: .dimension) ?? ""

            let residents: [String] = try container.decodeIfPresent([String].self, forKey: .residents) ?? []

            self.init(id: id,
                      name: name,
                      type: type,
                      dimension: dimension,
                      residents: residents)
        } catch {
            throw Err(sender: Location.self, error: error)
        }
    }
}
