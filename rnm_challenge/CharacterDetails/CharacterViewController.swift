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

        guard let id = viewModel?.originLocationId else { return }

        NetworkManager.shared.locationService.location(id: id) { (location, err) in
            DispatchQueue.main.async {
                if let location = location {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: LocationViewController.identifier)
                    (controller as? LocationViewController)?.viewModel = LocationViewModel(item: location)
                    self.present(controller, animated: true, completion: nil)
                } else {
                    print(err?.description)
                }
            }
        }
    }

}
