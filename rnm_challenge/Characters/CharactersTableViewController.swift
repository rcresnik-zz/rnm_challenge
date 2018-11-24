//
//  CharactersViewController.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

class CharactersTableViewController: UITableViewController {
    static let identifier = "CharactersViewController"
    var viewModel: CharactersViewModel?

//    var dataSource = CharacterTableViewDataSource()
    var isLoading = false

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CharacterTableViewCell.self)

        isLoading = true

        viewModel?.fetchData(completion: { (err) in
            if let err = err {
                print(err.description)
            } else {
                self.tableView.reloadData()
            }
            self.isLoading = false
        })
    }
}

// TableViewDelegate
extension CharactersTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = viewModel?.characters[indexPath.row] {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: CharacterViewController.identifier)
            (controller as? CharacterViewController)?.viewModel = CharacterViewModel(item: item)
            self.navigationController?.pushViewController(controller, animated: true)
//            NavigationManager.navigateFrom(self, to: controller)
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CharacterTableViewCell.height
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard isLoading == false,
            let count = viewModel?.characters.count
        else {
            return
        }

        if indexPath.row == count - 10 {
            isLoading = true
            
            viewModel?.fetchMore { (err) in
                if let err = err {
                    print(err.description)
                } else {
                    self.tableView.reloadData()
                }
                self.isLoading = false
            }
        }
    }
}

// UITableViewDataSource
extension CharactersTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = viewModel?.characters.count else {
            return 0
        }
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CharacterTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)

        if let item = viewModel?.characters[indexPath.row] {
            let viewModel = CharacterCellViewModel(item: item)
            cell.setup(viewModel: viewModel)
        }

        return cell
    }
}
