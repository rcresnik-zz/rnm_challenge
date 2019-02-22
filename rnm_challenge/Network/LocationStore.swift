//
//  LocationStore.swift
//  rnm_challenge
//
//  Created by rokit on 22/02/2019.
//  Copyright © 2019 rok cresnik. All rights reserved.
//

import Foundation

struct LocationStore: Answerable {
    func locations(ids: [Int], completion: @escaping CompletionBlock<[Location]>) {
        let url = URL.string(UrlConstants.Location.with(ids: ids))

        let getRequest = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            let result: Result<[Location]> = self.resultFrom(data: data, response: response, error: error)
            DispatchQueue.main.async() {
                completion(result)
            }
        }

        task.resume()
    }
}
