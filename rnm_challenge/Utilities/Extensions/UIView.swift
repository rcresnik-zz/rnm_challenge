//
//  UIView.swift
//  rnm_challenge
//
//  Created by rokit on 22/02/2019.
//  Copyright © 2019 rok cresnik. All rights reserved.
//

import UIKit

extension UIView {
    static func loadView<T: UIView>(identifier: String) -> T {
        if let view = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)?.first as? T {
            return view
        } else {
            fatalError()
        }
    }
}
