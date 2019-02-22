//
//  UIStoryboard.swift
//  rnm_challenge
//
//  Created by rokit on 21/02/2019.
//  Copyright © 2019 rok cresnik. All rights reserved.
//

import UIKit

protocol Identifieable {
    static var identifier: String { get }
}

extension Identifieable where Self: UIViewController {
    static var identifier: String {
        return NSStringFromClass(self).components(separatedBy: ".")[1]
    }
}

extension Identifieable where Self: UIView {
    static var identifier: String {
        return NSStringFromClass(self).components(separatedBy: ".")[1]
    }
}
