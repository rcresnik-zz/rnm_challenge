//
//  LocationViewController.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    static let identifier = "LocationViewController"

    var viewModel: LocationViewModel?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dimensionLabel: UILabel!

    @IBOutlet weak var residentCountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    func setup() {
        nameLabel.text = viewModel?.locationName
        typeLabel.text = viewModel?.typeName
        dimensionLabel.text = viewModel?.dimensionName
        residentCountLabel.text = viewModel?.residentsCount

        if let view = residentCountLabel.superview {
            view.layer.cornerRadius = 5
            view.layer.borderColor = #colorLiteral(red: 1, green: 0.659891367, blue: 0, alpha: 1)
            view.layer.borderWidth = 1

            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.residentsViewTapped(sender:)))
            view.addGestureRecognizer(gesture)
        }
    }

    @objc func residentsViewTapped(sender: UITapGestureRecognizer) {
        guard let ids = viewModel?.residentIds else { return }

        NetworkManager.shared.characterService.with(ids: ids) { (characters, err) in
            if let err = err {
                print(err.description)
            } else if let characters = characters {
                DispatchQueue.main.async() {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    guard let controller = storyboard.instantiateViewController(withIdentifier: CharactersTableViewController.identifier) as? CharactersTableViewController else {
                        return
                    }
                    controller.viewModel = CharactersViewModel(items: characters)
                    self.present(controller, animated: true, completion: nil)
                }
            }
        }
    }
}
