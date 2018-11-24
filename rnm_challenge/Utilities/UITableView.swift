//
//  UITableView.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

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
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    func register<T: UITableViewCell>(_: T.Type) where T: NibLoadableView, T: ReusableView {
        register(UINib(nibName: T.nibName, bundle: nil), forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Failed to deque cell with identifier: \(T.defaultReuseIdentifier)")
        }

        return cell
    }

    func selectedCell<T: UITableViewCell>() -> T? where T: ReusableView {
        guard let selectedIndexPath = self.indexPathForSelectedRow, let cell = self.cellForRow(at: selectedIndexPath) as? T else {
            return nil
        }

        return cell
    }
}
