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



//var characterId: Int
//var profileImageUrl: URL?
//var characterName: String
//
//var originLocation: String
//var originLocationId: Int?
//
//var lastKnownLocation: String
//var lastKnownLocationId: Int?
//
//var speciesName: String
//var genderSpecification: String
//var heartbeatStatus: String
//var creationText: String
//init(item: AnimatedCharacter) {
//    self.characterId = item.id
//    self.profileImageUrl = item.imageUrl
//    self.characterName = item.name
//
//    self.originLocation = item.origin.name
//    self.originLocationId = item.origin.id
//
//    self.lastKnownLocation = item.location.name
//    self.lastKnownLocationId = item.location.id
//
//    self.speciesName = item.species.rawValue
//    self.genderSpecification = item.gender.rawValue
//    self.heartbeatStatus = item.status.rawValue
//
//    var creationText = "id: \(item.id)"
//    if let created = item.created {
//        let difference = created.timeIntervalSinceNow
//        let years = Int(difference / (365 * 24 * 60 * 60))
//        let days = Int(difference / (24 * 60 * 60))
//        let hours = Int(difference / (60 * 60))
//        let minutes = Int(difference / 60)
//
//        if years > 0 {
//            creationText += " - created \(years) year/s ago"
//        } else if days > 0 {
//            creationText += " - created \(days) day/s ago"
//        } else if hours > 0 {
//            creationText += " - created \(hours) hour/s ago"
//        } else if minutes > 0 {
//            creationText += " - created \(minutes) min/s ago"
//        }
//    }
//    self.creationText = creationText
//}
