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
    private var currentPage: Int = 1
    private var canFetch: Bool = true

    init(items: [CharacterProtocol]) {
        self.characters = items
        if items.count > 0 {
            self.canFetch = false
        }
    }

    func addMore(characters: [CharacterProtocol]) {
        self.characters.append(contentsOf: characters)
    }

    func fetchData(completion: @escaping ((Err?) -> Void)) {
        guard canFetch == true else { return }
        
        NetworkManager.shared.characterService.all(page: currentPage) { (characters, err) in
            DispatchQueue.main.async() {
                if let err = err {
                    print(err.description)
                    completion(err)
                } else if let characters = characters {
                    self.addMore(characters: characters)
                    completion(nil)
                }
            }
        }
    }

    func fetchMore(completion: @escaping ((Err?) -> Void)) {
        currentPage += 1
        fetchData(completion: completion)
    }
}
