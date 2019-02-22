//
//  CharacterViewController.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {
    static let identifier = "CharacterViewController"

    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var creationLabel: UILabel!

    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var favoritesButton: UIButton!

    var characterId: Int = -1

    fileprivate var originId = -1
    fileprivate var locationId = -1
    
    var characterView: CharacterView = UIView.loadView(identifier: CharacterView.identifier)

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Details"

        characterView.frame = view.bounds
        view.addSubview(characterView)

        NetworkManager.shared.characterService.with(id: characterId) { [weak self] (result) in
            switch result {
            case .success(let characer):
                self?.originId = characer.origin.id ?? -1
                self?.locationId = characer.location.id ?? -1

                let viewModel = CharacterViewModel(item: characer)
                self?.characterView.setupWith(viewModel)
            case .failure(let err):
                print(err.description)
            }
        }
    }
}

extension CharacterViewController: Touchable {
    func favoriteTapped() {
        characterView.isFavorite = LocalStorage.toggleFavorite(id: characterId)
    }

    func originTapped() {
        goToLocation(id: originId)
    }

    func locationTapped() {
        goToLocation(id: locationId)
    }

    private func goToLocation(id: Int?) {
        if let id = id,
            id > 0,
            let controller = UIStoryboard.loadViewController(identifier: LocationViewController.identifier) as? LocationViewController {
            controller.locationId = locationId

            self.navigationController?.pushViewController(controller, animated: true)
        }
        else {
            return
        }
    }
}
