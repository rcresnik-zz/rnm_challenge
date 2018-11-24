//
//  CharacterComponent.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

class CharacterComponent {
    var viewController: CharactersViewController!

    var currentPage: Int = 1

    init () {

    }

    convenience init(container: UIView) {
        self.init()

        viewController = CharactersViewController(nibName: CharactersViewController.nibName, bundle: nil)
        viewController.view.frame = container.frame

        container.addSubview(viewController.view)
    }

    func resetDataSource(items: [CharacterCellProtocol]) {
        viewController.dataSource.items = [items]
    }

    func reload() {
        DispatchQueue.main.async {
            self.viewController.tableView.reloadData()
        }
    }
}
