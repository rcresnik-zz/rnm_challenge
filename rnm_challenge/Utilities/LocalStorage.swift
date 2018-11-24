//
//  LocalStorage.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

struct LocalStorage {
    private struct Keys {
        static let favorite = "Favorite"
    }

    static func favorites() -> [Int] {
        return UserDefaults.standard.array(forKey: LocalStorage.Keys.favorite) as? [Int] ?? []
    }

    static func addFavorite(id: Int) {
        var favorites = UserDefaults.standard.array(forKey: LocalStorage.Keys.favorite) as? [Int] ?? []
        favorites.append(id)
        favorites = Array(Set(favorites))

        UserDefaults.standard.set(favorites, forKey: LocalStorage.Keys.favorite)
    }

    static func removeFavorite(id: Int) {
        var favorites = UserDefaults.standard.array(forKey: LocalStorage.Keys.favorite) as? [Int] ?? []
        favorites = favorites.filter { $0 != id }

        UserDefaults.standard.set(favorites, forKey: LocalStorage.Keys.favorite)
    }

    static func removeAllFavorites() {
        UserDefaults.standard.removeObject(forKey: LocalStorage.Keys.favorite)
    }

    static func isFavorite(id: Int) -> Bool {
        let favorites = UserDefaults.standard.array(forKey: LocalStorage.Keys.favorite) as? [Int] ?? []

        return favorites.contains(id)
    }

    static func toggleFavorite(id: Int) {
        if LocalStorage.isFavorite(id: id) {
            LocalStorage.removeFavorite(id: id)
        } else {
            LocalStorage.addFavorite(id: id)
        }
    }
}
