//
//  SecondViewController.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Favorite characters"
        let ids = LocalStorage.favorites()

        NetworkManager.shared.characterService.with(ids: ids) { (characters, err) in
            if let err = err {
                print(err.description)
            } else if let characters = characters {
                DispatchQueue.main.async() {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    guard let controller = storyboard.instantiateViewController(withIdentifier: CharactersTableViewController.identifier) as? CharactersTableViewController
                        else {
                            print("Couldnt load 'CharactersTableViewController' from stroyboard!")
                            return
                    }

                    controller.viewModel = CharactersViewModel(items: characters)
                    controller.view.frame = self.view.bounds

                    self.addChild(controller)
                    self.view.addSubview(controller.view)
                    controller.didMove(toParent: self)
                }
            }
        }
    }
}

