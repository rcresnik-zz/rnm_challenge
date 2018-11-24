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

        title = "Location"
        setup()
    }

    func setup() {
        guard let viewModel = viewModel else { return }

        nameLabel.text = viewModel.locationName
        typeLabel.text = viewModel.typeName
        dimensionLabel.text = viewModel.dimensionName

        let attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                                                          NSAttributedString.Key.underlineColor: nameLabel.textColor]
        residentCountLabel.attributedText = NSAttributedString(string: viewModel.residentsCount, attributes: attributes)

        if let view = residentCountLabel.superview {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.residentsViewTapped(sender:)))
            view.addGestureRecognizer(gesture)
        }
    }

    @objc func residentsViewTapped(sender: UITapGestureRecognizer) {
        guard let ids = viewModel?.residentIds else { return }

        if ids.count == 1 {
            NetworkManager.shared.characterService.with(id: ids[0]) { (character, err) in
                DispatchQueue.main.async() {
                    if let err = err {
                        print(err.description)
                    } else if let character = character {
                        self.navigateToViewController(with: [character])
                    }
                }
            }
            return
        }

        NetworkManager.shared.characterService.with(ids: ids) { (characters, err) in
            DispatchQueue.main.async() {
                if let err = err {
                    print(err.description)
                } else if let characters = characters {
                    self.navigateToViewController(with: characters)
                }
            }
        }
    }

    private func navigateToViewController(with characters: [AnimatedCharacter]) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: CharactersTableViewController.identifier) as? CharactersTableViewController else {
            return
        }
        controller.title = self.viewModel?.locationName
        controller.viewModel = CharactersViewModel(items: characters, canFetch: false)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
