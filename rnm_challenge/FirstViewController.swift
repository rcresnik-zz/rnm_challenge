//
//  FirstViewController.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Rick and Morty"

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: CharactersTableViewController.identifier) as? CharactersTableViewController
        else {
             print("Couldnt load 'CharactersTableViewController' from stroyboard!")
            return
        }
        
        controller.viewModel = CharactersViewModel(items: [])
        controller.view.frame = view.bounds
        
        addChild(controller)
        view.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
}
