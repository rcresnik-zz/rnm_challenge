//
//  LocationViewModel.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

struct LocationViewModel: LocationProtocol {
    var locationName: String
    var typeName: String
    var dimensionName: String
    var residentsCount: String
    var residentIds: [Int]

    init(item: LocationProtocol) {
        self.locationName = item.locationName
        self.typeName = item.typeName
        self.dimensionName = item.dimensionName
        self.residentsCount = item.residentsCount
        self.residentIds = item.residentIds
    }
}
