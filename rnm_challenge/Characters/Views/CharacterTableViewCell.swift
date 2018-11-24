//
//  CharacterTableViewCell.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    static let height: CGFloat = 120

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!


    func setup(viewModel: CharacterProtocol) {
        if let url = viewModel.profileImageUrl {
            profileImageView.image(from: url)
        }
        nameLabel.text = viewModel.characterName
        locationLabel.text = viewModel.lastKnownLocation
        statusLabel.text = viewModel.lastKnownStatus
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.layer.masksToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = #imageLiteral(resourceName: "alien")
        nameLabel.text = "<<incognito>>"
        locationLabel.text = "<<unknown location>>"
        statusLabel.text = "<<unknown>>"
    }
}
