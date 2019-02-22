//
//  CharacterViewController.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController, Identifieable {
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
    
    var characterView: CharacterView = UIView.loadView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Details"

        characterView.frame = view.bounds
        view.addSubview(characterView)

        fetchData()
    }
}

// Fetching
extension CharacterViewController {
    func fetchData() {
        NetworkManager.shared.characterStore.with(ids: [characterId]) { (result) in
            switch result {
            case .success(let characters):
                let character = characters[0]

                self.originId = character.origin.id ?? -1
                self.locationId = character.location.id ?? -1

                let viewModel = CharacterViewModel(item: character)
                self.characterView.setup(viewModel: viewModel, viewController: self)
            case .failure(let err):
                print(err.description)
            }
        }
    }
}

extension CharacterViewController: CharacterProtocol {
    func favoriteTapped() {
        characterView.isFavorite = LocalStorage.toggleFavorite(id: characterId)
    }

    func originTapped() {
        navigateToViewController(with: originId)
    }

    func locationTapped() {
        navigateToViewController(with: locationId)
    }

    private func navigateToViewController(with locationId: Int) {
        if locationId > 0 {
            let controller: LocationViewController = UIStoryboard.loadViewController()
            controller.locationId = locationId

            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
