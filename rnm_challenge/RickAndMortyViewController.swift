//
//  FirstViewController.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

class RickAndMortyViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Rick and Morty"

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let controller = storyboard.instantiateViewController(withIdentifier: CharactersTableViewController.identifier) as? CharactersTableViewController {
            controller.viewModel = CharactersTableViewModel(items: [])
            controller.view.frame = view.bounds

            addChild(controller)
            view.addSubview(controller.view)
            controller.didMove(toParent: self)
        }
    }
}
