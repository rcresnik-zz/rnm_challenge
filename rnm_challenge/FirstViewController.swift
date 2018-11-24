//
//  FirstViewController.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    var characterComponent: CharacterComponent!

    override func viewDidLoad() {
        super.viewDidLoad()

        characterComponent = CharacterComponent(container: view)

        fetchData()
    }

    func fetchData() {
        NetworkApi.shared.all(page: 1) { (characters, err) in
            if let err = err {
                print(err.description)
            } else {
                self.characterComponent.resetDataSource(items: characters)
                self.characterComponent.reload()
            }
        }
    }
}
