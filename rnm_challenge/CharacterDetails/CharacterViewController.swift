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
    @IBOutlet weak var locationLabel: UILabel!

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
            profileImageView.layer.masksToBounds = true
            profileImageView.layer.borderColor = #colorLiteral(red: 1, green: 0.659891367, blue: 0, alpha: 1)
            profileImageView.layer.borderWidth = 5
        }
        nameLabel.text = viewModel.characterName
        let attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                                                          NSAttributedString.Key.underlineColor: nameLabel.textColor]
        originLabel.attributedText = NSAttributedString(string: viewModel.originLocation, attributes: attributes)
        locationLabel.attributedText = NSAttributedString(string: viewModel.lastKnownLocation, attributes: attributes)

        if let view = originLabel.superview {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.originTapped(sender:)))
            view.addGestureRecognizer(gesture)
        }

        if let view = locationLabel.superview {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.locationTapped(sender:)))
            view.addGestureRecognizer(gesture)
        }
    }

    @objc func originTapped(sender: UITapGestureRecognizer) {
        fetchData(id: viewModel?.originLocationId)
    }

    @objc func locationTapped(sender: UITapGestureRecognizer) {
        fetchData(id: viewModel?.lastKnownLocationId)
    }

    private func fetchData(id: Int?) {
        guard let id = id else { return }
        
        NetworkManager.shared.locationService.location(id: id) { (location, err) in
            DispatchQueue.main.async {
                if let location = location {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: LocationViewController.identifier)
                    (controller as? LocationViewController)?.viewModel = LocationViewModel(item: location)

                    self.navigationController?.pushViewController(controller, animated: true)
                } else if let err = err {
                    print(err.description)
                }
            }
        }
    }
}
