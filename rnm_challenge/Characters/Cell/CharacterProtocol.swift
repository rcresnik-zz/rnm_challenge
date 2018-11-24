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
}

extension AnimatedCharacter: CharacterProtocol {
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
