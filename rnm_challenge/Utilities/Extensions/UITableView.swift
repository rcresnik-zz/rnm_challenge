//
//  UITableView.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UITableViewCell {
    static var nibName: String {
        let nibName = NSStringFromClass(self).components(separatedBy: ".").last!
        return nibName
    }
}

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) where T: Identifieable {
        register(UINib(nibName: T.identifier, bundle: nil), forCellReuseIdentifier: T.identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: Identifieable {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Failed to deque cell with identifier: \(T.identifier)")
        }

        return cell
    }
}
