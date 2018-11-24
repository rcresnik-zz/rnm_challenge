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

struct AinmatedCharacter {
    let id: Int
    let name: String
    let status: Status
    let species: Species
    let type: String
    let gender: Gender
    let origin: Location
    let location: Location
    let imageUrl: URL?
    let episode: [URL?] // Could be [Episode?]
    let url: URL?
    let created: Date?
}

extension AinmatedCharacter: Decodable {
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

            let id = try container.decode(Int.self, forKey: .id)
            let name = try container.decode(String.self, forKey: .name)

            let status = Status(rawValue: try container.decode(String.self, forKey: .status).lowercased()) ?? .unknown
            let species = Species(rawValue: try container.decode(String.self, forKey: .species).lowercased()) ?? .unknown
            let type = try container.decode(String.self, forKey: .type)
            let gender = Gender(rawValue: try container.decode(String.self, forKey: .gender).lowercased()) ?? .unknown

            let origin = try container.decode(Location.self, forKey: .origin)

            let location = try container.decode(Location.self, forKey: .location)
            let imageUrl = URL(string: try container.decode(String.self, forKey: .imageUrl))

            let episodesArray = try container.decode([String].self, forKey: .episode)
            let episodes = episodesArray.map { URL(string: $0) }
            let url = URL(string: try container.decode(String.self, forKey: .url))

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let created = dateFormatter.date(from: try container.decode(String.self, forKey: .created))

//            2017-11-04T18:48:46.250Z"

            self.init(id: id,
                      name: name,
                      status: status,
                      species: species,
                      type: type,
                      gender: gender,
                      origin: origin,
                      location: location,
                      imageUrl: imageUrl,
                      episode: episodes,
                      url: url,
                      created: created)
        } catch {
            throw Err(sender: AinmatedCharacter.self, error: error)
        }
    }
}
