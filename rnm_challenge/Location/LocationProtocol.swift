//
//  LocationProtocol.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

protocol LocationProtocol {
    var locationName: String { get }
    var typeName: String { get }
    var dimensionName: String { get }
    var residentsCount: String { get }
}

extension Location: LocationProtocol {
    var locationName: String {
        return name
    }

    var typeName: String {
        return type.rawValue
    }

    var dimensionName: String {
        return dimension
    }

    var residentsCount: String {
        return "\(residents.count)"
    }
}
