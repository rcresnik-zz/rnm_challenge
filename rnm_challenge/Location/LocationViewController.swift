//
//  LocationViewController.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController, Identifieable {
    static var identifier = "LocationViewController"

    var locationId: Int = -1
    var residentIds: [Int] = []

    var locationView: LocationView = UIView.loadView(identifier: LocationView.identifier)

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Location"

        locationView.frame = view.bounds
        view.addSubview(locationView)

        fetchData()
    }
}

extension LocationViewController {
    func fetchData() {
        NetworkManager.shared.locationStore.locations(ids: [locationId]) { (result) in
            switch result {
            case .success(let locations):
                let location = locations[0]
                self.residentIds = location.residentIds

                self.locationView.setup(viewModel: LocationViewModel(item: location), viewController: self)
            case .failure(let err):
                print(err.description)
            }
        }
    }
}

extension LocationViewController: LocationProtocol {
    func residentsTapped() {
        let controller: CharactersViewController = UIStoryboard.loadViewController()
        controller.title = locationView.nameLabel.text
        controller.ids = residentIds

        self.navigationController?.pushViewController(controller, animated: true)
    }
}
