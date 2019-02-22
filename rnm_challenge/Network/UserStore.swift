//
//  UserStore.swift
//  rnm_challenge
//
//  Created by rokit on 22/02/2019.
//  Copyright © 2019 rok cresnik. All rights reserved.
//

import Foundation

struct CharacterStore: Answerable {
    func with(ids: [Int]? = nil, page: Int? = nil, completion: @escaping CompletionBlock<[AnimatedCharacter]>) {

        var url: URL
        if let urlString = UrlConstants.Character.with(ids: ids, page: page) {
            url = URL.string(urlString)
        } else {
            let result = Result<[AnimatedCharacter]>.failure(Err(description: "Couldn't generate URL."))
            completion(result)
            return
        }

        let getRequest = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            let result: Result<[AnimatedCharacter]> = self.resultFrom(data: data, response: response, error: error)
            DispatchQueue.main.async() {
                completion(result)
            }
        }
        task.resume()
    }
}
