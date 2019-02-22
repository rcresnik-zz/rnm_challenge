//
//  URL.swift
//  rnm_challenge
//
//  Created by rokit on 22/02/2019.
//  Copyright © 2019 rok cresnik. All rights reserved.
//

import UIKit

extension URL {
    static func string(_ string: String) -> URL {
        if let url = URL(string: string) {
            return url
        } else {
            fatalError()
        }
    }
}
