//
//  LocationViewModel.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

struct LocationViewModel {
    var locationName: String
    var typeName: String
    var dimensionName: String
    var residentsText: NSAttributedString

    init(item: Location) {
        self.locationName = item.name
        self.typeName = item.type.rawValue
        self.dimensionName = item.dimension

        let residentsText = "\(item.residents.count) \(item.residents.count == 1 ? "resident" : "residents")"

        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.underlineColor: UIColor.rnmOrange]

        self.residentsText = NSAttributedString(string: residentsText, attributes: attributes)
    }
}
