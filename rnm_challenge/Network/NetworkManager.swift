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

    let characterStore: CharacterStore = CharacterStore()
    let locationStore: LocationStore = LocationStore()
}
