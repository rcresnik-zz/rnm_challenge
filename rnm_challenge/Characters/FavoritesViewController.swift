//
//  SecondViewController.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, Identifieable {
    var controller: CharactersViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Favorite characters"

        let controller: CharactersViewController = UIStoryboard.loadViewController()
        controller.view.frame = view.bounds
        controller.canFetch = false
        controller.canEdit = true
        controller.page = 0
        self.controller = controller

        addChild(controller)
        view.addSubview(controller.view)
        controller.didMove(toParent: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        controller?.page = 0
        controller?.ids = LocalStorage.favorites()
    }
}
