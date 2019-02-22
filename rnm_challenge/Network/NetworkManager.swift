//
//  NetworkManager.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Err)
}

typealias CompletionBlock<T> = (Result<T>) -> Void

class NetworkManager {
    let host: String

    static let shared = NetworkManager(host: UrlConstants.baseUrl)

    init(host: String) {
        self.host = host
    }

    let characterService: CharacterService = CharacterService()
    let locationService: LocationService = LocationService()
}

protocol Answerable {
    func resultFrom<T: Decodable>(data: Data?, response: URLResponse?, error: Error?) -> Result<T>
    func resultArrayFrom<T: Decodable>(data: Data?, response: URLResponse?, error: Error?) -> Result<[T]>
}

extension Answerable {
    func resultArrayFrom<T: Decodable>(data: Data?, response: URLResponse?, error: Error?) -> Result<[T]> {
        var result: Result<[T]> = Result.failure(Err(description: "Unknown error"))
        var someError: Err?
        if let data = data {
            do {
                let objects =  try JSONDecoder().decode(NetworkObject<T>.self, from: data).results
                result = Result.success(objects)
            } catch {
                someError = Err(sender: NetworkManager.self, error: error)
            }
        } else if let error = error {
            someError = Err(sender: T.self, error: error)
        } else {
            someError = Err(description: "Networking: Unknown error occured")
        }

        if let err = someError {
            result = Result.failure(err)
        }

        return result
    }

    func resultFrom<T: Decodable>(data: Data?, response: URLResponse?, error: Error?) -> Result<T> {
        var result: Result<T> = Result.failure(Err(description: "Unknown error"))
        var someError: Err?
        if let data = data {
            do {
                let object =  try JSONDecoder().decode(T.self, from: data)
                result = Result.success(object)
            } catch {
                someError = Err(sender: NetworkManager.self, error: error)
            }
        } else if let error = error {
            someError = Err(sender: T.self, error: error)
        } else {
            someError = Err(description: "Networking: Unknown error occured")
        }

        if let err = someError {
            result = Result.failure(err)
        }

        return result
    }
}

class CharacterService: Answerable {

    func all(page: Int = 1, completion: @escaping CompletionBlock<[AnimatedCharacter]>) {
        let url = URL.string(UrlConstants.Character.all(page: page))

        let getRequest = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            let result: Result<[AnimatedCharacter]> = self.resultArrayFrom(data: data, response: response, error: error)
            DispatchQueue.main.async() {
                completion(result)
            }
        }
        task.resume()
    }

    func with(id: Int, completion: @escaping CompletionBlock<AnimatedCharacter>) {
        let url = URL.string(UrlConstants.Character.with(id: id))

        let getRequest = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            let result: Result<AnimatedCharacter> = self.resultFrom(data: data, response: response, error: error)
            DispatchQueue.main.async() {
                completion(result)
            }
        }
        task.resume()

    }

    func with(ids: [Int], completion: @escaping CompletionBlock<[AnimatedCharacter]>) {
        let url = URL.string(UrlConstants.Character.with(ids: ids))

        let getRequest = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            let result: Result<[AnimatedCharacter]> = self.resultArrayFrom(data: data, response: response, error: error)
            DispatchQueue.main.async() {
                completion(result)
            }
        }
        task.resume()
    }
}

class LocationService: Answerable {
    func location(id: Int, completion: @escaping CompletionBlock<Location>) {
        let url = URL.string(UrlConstants.Location.with(id: id))

        let getRequest = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            let result: Result<Location> = self.resultFrom(data: data, response: response, error: error)
            DispatchQueue.main.async() {
                completion(result)
            }
        }
        
        task.resume()
    }
}
