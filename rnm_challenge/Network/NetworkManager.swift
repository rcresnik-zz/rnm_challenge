//
//  NetworkManager.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

typealias CompletionBlock<T> = (T?, Err?) -> Void

class NetworkManager {
    let host: String

    static let shared = NetworkManager(host: UrlConstants.baseUrl)

    init(host: String) {
        self.host = host
    }

    let characterService: CharacterService = CharacterService()
    let locationService: LocationService = LocationService()
}

class CharacterService {
    func all(page: Int = 1, completion: @escaping CompletionBlock<[AnimatedCharacter]>) {
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
                    let err = Err(sender: CharacterService.self, error: error)
                    completion([], err)
                }
            } else if let error = error {
                let err = Err(sender: CharacterService.self, error: error)
                completion([], err)
            } else {
                let err = Err(description: "Networking: Unknown error occured")
                completion([], err)
            }
        }
        task.resume()
    }

    func with(ids: [Int], completion: @escaping CompletionBlock<[AnimatedCharacter]>) {
        guard let url = URL(string: UrlConstants.Character.with(ids: ids))
            else {
                let err = Err(description: "Error creating URL")
                completion(nil, err)
                return
        }

        let getRequest = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            if let data = data {
                do {
                    let characters = try JSONDecoder().decode([AnimatedCharacter].self, from: data)
                    completion(characters, nil)
                } catch let err as Err {
                    completion([], err)
                } catch {
                    let err = Err(sender: CharacterService.self, error: error)
                    completion([], err)
                }
            } else if let error = error {
                let err = Err(sender: CharacterService.self, error: error)
                completion([], err)
            } else {
                let err = Err(description: "Networking: Unknown error occured")
                completion([], err)
            }
        }
        task.resume()
    }
}

class LocationService {
    func location(id: Int, completion: @escaping CompletionBlock<Location>) {
        guard let url = URL(string: UrlConstants.Location.with(id: id))
        else {
            let err = Err(description: "Error creating URL")
            completion(nil, err)
            return
        }

        let getRequest = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            if let data = data {
                do {
                    let location = try JSONDecoder().decode(Location.self, from: data)
                    completion(location, nil)
                } catch let err as Err {
                    completion(nil, err)
                } catch {
                    let err = Err(sender: CharacterService.self, error: error)
                    completion(nil, err)
                }
            } else if let error = error {
                let err = Err(sender: CharacterService.self, error: error)
                completion(nil, err)
            } else {
                let err = Err(description: "Networking: Unknown error occured")
                completion(nil, err)
            }
        }
        task.resume()
    }
}
