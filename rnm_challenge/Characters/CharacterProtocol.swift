//
//  CharacterCellProtocol.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

protocol CharacterProtocol {
    var profileImageUrl: URL? { get }
    var characterName: String { get }
    var originLocation: String? { get }
    var originLocationId: Int? { get }
    var lastKnownLocation: String { get }
    var lastKnownStatus: String { get }
}

extension AnimatedCharacter: CharacterProtocol {
    var profileImageUrl: URL? {
        return imageUrl
    }

    var characterName: String {
        return name
    }

    var originLocation: String? {
        return origin.name
    }

    var originLocationId: Int? {
        return origin.id
    }

    var lastKnownLocation: String {
        return location.name
    }

    var lastKnownStatus: String {
        return self.status.rawValue
    }
}
