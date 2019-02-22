//
//  LocationView.swift
//  rnm_challenge
//
//  Created by rokit on 22/02/2019.
//  Copyright © 2019 rok cresnik. All rights reserved.
//

import UIKit

@objc protocol LocationProtocol where Self: UIViewController {
    func residentsTapped()
}

class LocationView: UIView, Identifieable {
    @IBOutlet weak internal var nameLabel: UILabel!
    @IBOutlet weak internal var typeLabel: UILabel!
    
    @IBOutlet weak internal var dimensionLabel: UILabel!
    @IBOutlet weak internal var residentLabel: UILabel!

    func setup(viewModel: LocationViewModel, viewController: LocationProtocol? = nil) {
        nameLabel.text = viewModel.locationName
        typeLabel.text = viewModel.typeName

        dimensionLabel.text = viewModel.dimensionName
        residentLabel.attributedText = viewModel.residentsText

        if let vc = viewController {
            let gesture = UITapGestureRecognizer(target: vc,
                                                 action: #selector(LocationProtocol.residentsTapped))
            residentLabel.superview?.addGestureRecognizer(gesture)
        }
    }
}
