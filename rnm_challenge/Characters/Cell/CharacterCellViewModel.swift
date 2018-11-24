//
//  CharacterCellViewModel.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

struct CharacterCellViewModel: CharacterProtocol {
    var characterId: Int
    var profileImageUrl: URL?
    var characterName: String

    var originLocation: String
    var originLocationId: Int

    var lastKnownLocation: String
    var lastKnownLocationId: Int

    init(item: CharacterProtocol) {
        self.characterId = item.characterId
        self.profileImageUrl = item.profileImageUrl
        self.characterName = item.characterName
        
        self.originLocation = item.originLocation
        self.originLocationId = item.originLocationId

        self.lastKnownLocation = item.lastKnownLocation
        self.lastKnownLocationId = item.lastKnownLocationId
    }
}
