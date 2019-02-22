//
//  UIStoryboard.swift
//  rnm_challenge
//
//  Created by rokit on 22/02/2019.
//  Copyright © 2019 rok cresnik. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static func loadViewController<T: Identifieable>() -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: T.identifier) as? T {
            return controller
        } else {
            fatalError("Failed to load view controller with identifier: \(T.identifier)")
        }
    }
}
