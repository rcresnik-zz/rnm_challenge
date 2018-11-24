//
//  CharacterViewController.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    
    @IBOutlet weak var locationButton: UIButton!

    var viewModel: CharacterViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }

    func setup() {
        guard let viewModel = viewModel
        else {
            return
        }
        if let url = viewModel.profileImageUrl {
            profileImageView.image(from: url)
        }
        nameLabel.text = viewModel.characterName
        originLabel.text = viewModel.originLocation
        locationButton.setTitle(viewModel.lastKnownLocation, for: .normal)
    }


    @IBAction func locationButtonTapped(_ sender: UIButton) {
        sender.isEnabled = false

//        NetworkManager.shared.locationService.location(id: <#T##Int#>) { (location, err) in
//            if let location = location {
//
//            } else {
//                print(err?.description)
//            }
//        }
    }

}
