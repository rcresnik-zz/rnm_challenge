//
//  SecondViewController.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    var controller: CharactersTableViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Favorite characters"

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: CharactersTableViewController.identifier) as? CharactersTableViewController
            else {
                print("Couldnt load 'CharactersTableViewController' from stroyboard!")
                return
        }
        controller.viewModel = CharactersTableViewModel(items: [], canFetch: false)
        controller.view.frame = view.bounds
        controller.canEdit = true

        addChild(controller)
        view.addSubview(controller.view)
        controller.didMove(toParent: self)

        self.controller = controller
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let ids = LocalStorage.favorites()
        
        NetworkManager.shared.characterService.with(ids: ids) { (result) in
            switch result {
            case .success(let characters):
                self.controller?.viewModel.resetCharacters(characters)
                self.controller?.tableView.reloadData()
            case .failure(let err):
                print(err.description)
            }
        }
    }
}
