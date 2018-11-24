//
//  NetworkApi.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

class NetworkApi {
    let host: String

    static let shared = NetworkApi(host: UrlConstants.baseUrl)

    init(host: String) {
        self.host = host
    }
}

//  Character calls
extension NetworkApi {
    func all(page: Int = 1, completion: @escaping  (([AnimatedCharacter], Err?) -> Void)) {
        guard let url = URL(string: UrlConstants.Character.all(page: page)) else {
            let err = Err(description: "Error creating URL")
            completion([], err)
            return
        }
        let getRequest = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
          if let data = data {
                do {
                    let results = try JSONDecoder().decode(NetworkObject<AnimatedCharacter>.self, from: data).results
                    completion(results, nil)
                } catch let err as Err {
                    completion([], err)
                } catch {
                    let err = Err(sender: NetworkApi.self, error: error)
                    completion([], err)
                }
            } else if let error = error {
                let err = Err(sender: NetworkApi.self, error: error)
                completion([], err)
            } else {
                let err = Err(description: "Networking: Unknown error occured")
                completion([], err)
            }
        }
        task.resume()
    }
}
