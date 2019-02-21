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

            self.id = try container.decodeIfPresent(Int.self, forKey: .id)
            self.name = try container.decode(String.self, forKey: .name)

            let typeString = try container.decodeIfPresent(String.self, forKey: .type)
            self.type = LocationType(rawValue: typeString?.lowercased() ?? "") ?? .unknown

            self.dimension = try container.decodeIfPresent(String.self, forKey: .dimension) ?? ""

            self.residents = try container.decodeIfPresent([String].self, forKey: .residents) ?? []
        } catch {
            throw Err(sender: Location.self, error: error)
        }
    }
}
