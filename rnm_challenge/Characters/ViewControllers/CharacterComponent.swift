//
//  CharacterComponent.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

class CharacterComponent {
    var viewController: CharactersTableViewController!

    var currentPage: Int = 1

    init () {

    }

    convenience init(container: UIView) throws {
        self.init()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: CharactersTableViewController.identifier) as? CharactersTableViewController
        else {
            throw Err(description: "Couldnt load 'CharactersTableViewController' from stroyboard!")
        }
        controller.viewModel = CharactersViewModel(items: [])
        viewController = controller
        viewController.view.frame = container.frame

        container.addSubview(viewController.view)
    }

    func reload() {
        DispatchQueue.main.async {
            self.viewController.tableView.reloadData()
        }
    }
}
