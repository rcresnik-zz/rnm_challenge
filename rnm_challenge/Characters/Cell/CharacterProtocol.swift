//
//  CharacterCellProtocol.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

protocol CharacterProtocol {
    var characterId: Int { get }
    var profileImageUrl: URL? { get }
    var characterName: String { get }
    var originLocation: String { get }

    var originLocationId: Int { get }
    var lastKnownLocation: String { get }
    var lastKnownLocationId: Int { get }

    var speciesName: String { get }
    var genderSpecification: String { get }
    var heartbeatStatus: String { get }

    var creationText: String { get }
}

extension AnimatedCharacter: CharacterProtocol {
    var speciesName: String {
        return species.rawValue
    }

    var genderSpecification: String {
        return gender.rawValue
    }

    var heartbeatStatus: String {
        return status.rawValue
    }

    var creationText: String {
        var creationText = "id: \(id)"
        if let created = created {
            let difference = created.timeIntervalSinceNow
            let years = Int(difference / (365 * 24 * 60 * 60))
            let days = Int(difference / (24 * 60 * 60))
            let hours = Int(difference / (60 * 60))
            let minutes = Int(difference / 60)
            
            if years > 0 {
                creationText += " - created \(years) year/s ago"
            } else if days > 0 {
                creationText += " - created \(days) day/s ago"
            } else if hours > 0 {
                creationText += " - created \(hours) hour/s ago"
            } else if minutes > 0 {
                creationText += " - created \(minutes) min/s ago"
            }
        }

        return creationText
    }

    var characterId: Int {
        return id
    }
    var originLocationId: Int {
        return origin.id ?? -1
    }

    var lastKnownLocation: String {
        return location.name
    }

    var lastKnownLocationId: Int {
        return location.id ?? -1
    }

    var profileImageUrl: URL? {
        return imageUrl
    }

    var characterName: String {
        return name
    }

    var originLocation: String {
        return origin.name
    }
}
