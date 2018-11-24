//
//  CharacterCellViewModel.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

struct CharacterCellViewModel: CharacterCellProtocol {
    var profileImageUrl: URL?
    var characterName: String
    var lastKnownLocation: String
    var lastKnownStatus: String
    var name: String
    var imageURL: URL?

    init(item: CharacterCellProtocol) {
        self.profileImageUrl = item.profileImageUrl
        self.characterName = item.characterName
        self.lastKnownLocation = item.lastKnownLocation
        self.lastKnownStatus = item.lastKnownStatus
        self.name = item.characterName
        self.imageURL = item.profileImageUrl
    }
}
