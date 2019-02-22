//
//  CharacterView.swift
//  rnm_challenge
//
//  Created by rokit on 21/02/2019.
//  Copyright © 2019 rok cresnik. All rights reserved.
//

import UIKit

protocol CharacterViewProtocol {
    func locationClicked()
    func favoritesClicked(sender: UIButton)
}

class CharacterView: UIView, Identifieable {
    var isFavorite: Bool = false {
        didSet {
            let title = CharacterViewModel.favoritesButtonTitleFor(isFavorite)
            favoritesButton.setTitle(title, for: .normal)
        }
    }

    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var creationLabel: UILabel!

    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    @IBOutlet weak var favoritesButton: UIButton!
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    func setupWith(_ viewModel: CharacterViewModel, viewController: CharacterProtocol? = nil) {
        isFavorite = viewModel.isFavorite

        profileImageView.image(from: viewModel.profileImageUrl)

        nameLabel.text = viewModel.characterName
        creationLabel.text = viewModel.creationText

        speciesLabel.text = viewModel.speciesName
        genderLabel.text = viewModel.genderSpecification
        statusLabel.text = viewModel.heartbeatStatus

        originLabel.text = viewModel.originLocation
        locationLabel.text = viewModel.lastKnownLocation

        if let vc = viewController {
            var gesture = UITapGestureRecognizer(target: vc,
                                                 action: #selector(CharacterProtocol.originTapped))
            originLabel.superview?.addGestureRecognizer(gesture)

            gesture = UITapGestureRecognizer(target: vc,
                                             action: #selector(CharacterProtocol.locationTapped))

            locationLabel.superview?.addGestureRecognizer(gesture)

            favoritesButton.addTarget(vc,
                                      action: #selector(CharacterProtocol.favoriteTapped), for: .touchDown)
        }
    }


}

@objc protocol CharacterProtocol where Self: UIViewController {
    func originTapped()

    func locationTapped()

    func favoriteTapped()
}
