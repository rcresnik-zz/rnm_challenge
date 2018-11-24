//
//  CharacterViewModel.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

struct CharacterViewModel: CharacterProtocol {
    var profileImageUrl: URL?
    var characterName: String
    var originLocation: String?
    var originLocationId: Int?
    var lastKnownLocation: String
    var lastKnownStatus: String
    var name: String
    var imageURL: URL?

    init(item: CharacterProtocol) {
        self.profileImageUrl = item.profileImageUrl
        self.characterName = item.characterName
        self.originLocation = item.originLocation ?? "unknown"
        self.lastKnownLocation = item.lastKnownLocation
        self.lastKnownStatus = item.lastKnownStatus
        self.name = item.characterName
        self.imageURL = item.profileImageUrl
        self.originLocationId = item.originLocationId
    }
}
