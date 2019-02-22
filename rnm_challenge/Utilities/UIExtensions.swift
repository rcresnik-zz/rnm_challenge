//
//  UIStoryboard.swift
//  rnm_challenge
//
//  Created by rokit on 21/02/2019.
//  Copyright © 2019 rok cresnik. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static func loadViewController<T: UIViewController>(identifier: String) -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? T {
            return controller
        } else {
            fatalError()
        }
    }
}

extension URL {
    static func string(_ string: String) -> URL {
        if let url = URL(string: string) {
            return url
        } else {
            fatalError()
        }
    }
}

extension UIView {
    static func loadView<T: UIView>(identifier: String) -> T {
        if let view = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)?.first as? T {
        return view
        } else {
            fatalError()
        }
    }
}
