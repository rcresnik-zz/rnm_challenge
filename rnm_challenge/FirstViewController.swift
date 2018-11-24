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
    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            characterComponent = try CharacterComponent(container: containerView)
        } catch let err as Err {
            print(err.description)
        } catch {
            print(error.localizedDescription)
        }
    }
}
