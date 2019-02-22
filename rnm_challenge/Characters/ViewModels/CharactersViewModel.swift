//
//  CharactersViewModel.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

class CharactersViewModel {
    var characters: [CharacterCellViewModel] = []

    init(items: [AnimatedCharacter]) {
        self.characters = items.map { CharacterCellViewModel(item: $0) }
    }

    func addCharacters(_ characters: [AnimatedCharacter]) {
        self.characters.append(contentsOf: characters.map { CharacterCellViewModel(item: $0) })
    }

    func removeFavoriteCharacter(index: Int) {
        let id = characters[index].characterId
        LocalStorage.removeFavorite(id: id)

        characters.remove(at: index)
    }

    func resetCharacters(_ items: [AnimatedCharacter]) {
        let viewModels = items.map { CharacterCellViewModel(item: $0) }
        characters = viewModels
    }
}
