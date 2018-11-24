//
//  CharactersViewController.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

class CharactersTableViewController: UITableViewController {
    static let nibName = "CharactersViewController"
    var dataSource = CharacterTableViewDataSource()
    var isLoading = false
    var selectedItem: CharacterProtocol? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CharacterTableViewCell.self)
        tableView.dataSource = self.dataSource
        tableView.delegate = self

        isLoading = true
        dataSource.fetchData { (section, err) in
            if let err = err {
                print(err.description)
            } else {
                self.tableView.reloadData()
            }
            self.isLoading = false
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let ds = tableView.dataSource as? CharacterTableViewDataSource {
            let item = ds.item(for: indexPath)
            selectedItem = item

            performSegue(withIdentifier: SegueIdentifiers.characterDetails, sender: self)
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CharacterTableViewCell.height
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isLoading {
            return
        }

        if indexPath.section == dataSource.items.count - 1 {
            isLoading = true
            
            dataSource.fetchMore { (section, err) in
                if let err = err {
                    print(err.description)
                } else {
                    self.tableView.reloadData()
                }
                self.isLoading = false
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CharacterViewController {
            if let item = selectedItem {
                vc.viewModel = CharacterViewModel(item: item)
            }
        }
    }
}
