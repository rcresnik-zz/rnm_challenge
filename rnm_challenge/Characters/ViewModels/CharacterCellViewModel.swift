//
//  CharacterViewModel.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

struct CharacterCellViewModel {
    var characterId: Int
    var profileImageUrl: URL?
    var characterName: String
    var originLocation: String

    init(item: AnimatedCharacter) {
        self.characterId = item.id
        self.profileImageUrl = item.imageUrl
        self.characterName = item.name
        self.originLocation = item.origin.name
    }
}
