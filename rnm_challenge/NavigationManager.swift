//
//  Navigator.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

struct NavigationManager {
    static func navigateFrom(_ from: UIViewController?, to: UIViewController?) {
        guard let from = from,
            let to = to
        else {
            return
        }

        if let navigationController = from.parent as? UINavigationController {
            navigationController.pushViewController(to, animated: true)
        } else {
            from.present(to, animated: true, completion: nil)
        }
    }
}
