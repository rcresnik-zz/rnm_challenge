//
//  Character.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

enum Status: String {
    case alive
    case dead
    case unknown
}

enum Species: String {
    case human
    case unknown
}

enum Gender: String {
    case male
    case female
    case unknown
}

struct AnimatedCharacter {
    let id: Int
    let name: String
    let status: Status
    let species: Species
    let type: String
    let gender: Gender
    let origin: Location
    let location: Location
    let imageUrl: URL?
    let episodes: [URL?] // Could be [Episode?]
    let url: URL?
    let created: Date?
}

extension AnimatedCharacter: Decodable {
    private enum PropertyKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case type
        case gender
        case origin
        case location
        case imageUrl = "image"
        case episode
        case url
        case created
    }

    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: PropertyKeys.self)

            self.id = try container.decode(Int.self, forKey: .id)
            self.name = try container.decode(String.self, forKey: .name)

            self.status = Status(rawValue: try container.decode(String.self, forKey: .status).lowercased()) ?? .unknown
            self.species = Species(rawValue: try container.decode(String.self, forKey: .species).lowercased()) ?? .unknown
            self.type = try container.decode(String.self, forKey: .type)
            self.gender = Gender(rawValue: try container.decode(String.self, forKey: .gender).lowercased()) ?? .unknown

            self.origin = try container.decode(Location.self, forKey: .origin)

            self.location = try container.decode(Location.self, forKey: .location)
            self.imageUrl = URL(string: try container.decode(String.self, forKey: .imageUrl))

            let episodesArray = try container.decode([String].self, forKey: .episode)
            self.episodes = episodesArray.map { URL(string: $0) }
            self.url = URL(string: try container.decode(String.self, forKey: .url))

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            self.created = dateFormatter.date(from: try container.decode(String.self, forKey: .created))
        } catch {
            throw Err(sender: AnimatedCharacter.self, error: error)
        }
    }
}
