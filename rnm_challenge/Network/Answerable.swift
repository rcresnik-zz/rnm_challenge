//
//  Answerable.swift
//  rnm_challenge
//
//  Created by rokit on 22/02/2019.
//  Copyright © 2019 rok cresnik. All rights reserved.
//

import Foundation

protocol Answerable {
    func resultFrom<T: Decodable>(data: Data?, response: URLResponse?, error: Error?) -> Result<[T]>
}

extension Answerable {
    func resultFrom<T: Decodable>(data: Data?, response: URLResponse?, error: Error?) -> Result<[T]> {
        var result: Result<[T]> = Result.failure(Err(sender: Answerable.self, description: "Unknown error"))

        if let data = data {
            if let objects =  try? JSONDecoder().decode(NetworkObject<T>.self, from: data).results {
                result = Result.success(objects)
            } else if let objects =  try? JSONDecoder().decode([T].self, from: data) {
                result = Result.success(objects)
            } else if let object = try? JSONDecoder().decode(T.self, from: data) {
                result = Result.success([object])
            } else {
                result = Result.failure(Err(sender: Answerable.self, description: "Decoding error"))
            }
        }

        return result
    }
}
