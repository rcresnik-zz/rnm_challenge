//
//  CharacterViewModel.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

struct CharacterViewModel: CharacterProtocol {
    var characterId: Int
    var profileImageUrl: URL?
    var characterName: String

    var originLocation: String
    var originLocationId: Int
    
    var lastKnownLocation: String
    var lastKnownLocationId: Int

    var speciesName: String
    var genderSpecification: String
    var heartbeatStatus: String
    var creationText: String

    init(item: CharacterProtocol) {
        self.characterId = item.characterId
        self.profileImageUrl = item.profileImageUrl
        self.characterName = item.characterName

        self.originLocation = item.originLocation
        self.originLocationId = item.originLocationId

        self.lastKnownLocation = item.lastKnownLocation
        self.lastKnownLocationId = item.lastKnownLocationId

        self.speciesName = item.speciesName
        self.genderSpecification = item.genderSpecification
        self.heartbeatStatus = item.heartbeatStatus
        self.creationText = item.creationText
    }
}
