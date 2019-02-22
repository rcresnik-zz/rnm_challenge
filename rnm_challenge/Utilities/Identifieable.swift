//
//  UIStoryboard.swift
//  rnm_challenge
//
//  Created by rokit on 21/02/2019.
//  Copyright © 2019 rok cresnik. All rights reserved.
//

import UIKit

protocol Identifieable where Self: UIViewController {
    static var identifier: String { get }
}
