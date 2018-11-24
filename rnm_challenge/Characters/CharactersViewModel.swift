//
//  CharactersViewModel.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

class CharactersViewModel {
    var characters: [CharacterProtocol] = []
    var pageNumber: Int = 1
    var canFetch: Bool

    init(items: [CharacterProtocol], canFetch: Bool = true) {
        self.characters = items
        self.canFetch = canFetch
    }

    func addMore(characters: [CharacterProtocol]) {
        self.characters.append(contentsOf: characters)
    }

    func fetchData(page: Int = 1, completion: @escaping ((Err?) -> Void)) {
        guard canFetch == true else {
            let err = Err(description: "Not allowed to fetch!")
            completion(err)
            return
        }

        
        NetworkManager.shared.characterService.all(page: pageNumber) { (characters, err) in
            DispatchQueue.main.async() {
                if let err = err {
                    print(err.description)
                    completion(err)
                } else if let characters = characters {
                    if page == 1 {
                        self.resetCharacters(items: characters)
                    } else {
                        self.addMore(characters: characters)
                    }
                    completion(nil)
                }
            }
        }
    }

    func fetchMore(completion: @escaping ((Err?) -> Void)) {
        pageNumber += 1
        fetchData(page: pageNumber, completion: completion)
    }

    func removeFavoriteCharacter(index: Int) {
        let id = characters[index].characterId
        LocalStorage.removeFavorite(id: id)

        characters.remove(at: index)
    }

    func resetCharacters(items: [CharacterProtocol]) {
        characters = items
    }
}
