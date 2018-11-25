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
    var canEdit = false

    @IBOutlet weak var refreshControll: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CharacterTableViewCell.self)
        refreshControl?.addTarget(self, action: #selector(self.refreshData), for: UIControl.Event.valueChanged)

        if let viewModel = viewModel,
            viewModel.canFetch == false {
            refreshControll.removeFromSuperview()
        }
        refreshData()
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
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CharacterTableViewCell.height
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard refreshControll.isRefreshing == false,
            let count = viewModel?.characters.count
        else {
            return
        }

        if indexPath.row == count - 10 {
            viewModel?.fetchMore { (err) in
                if let err = err {
                    print(err.description)
                } else {
                    let indexes: [IndexPath] = (count..<count + 20).map { IndexPath(row: $0, section: 0) }
                    self.tableView.insertRows(at: indexes, with: UITableView.RowAnimation.fade)
                }
                self.refreshControll.endRefreshing()
            }
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return canEdit
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete,
            let viewModel = viewModel {
            viewModel.removeFavoriteCharacter(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
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
            let viewModel = CharacterViewModel(item: item)
            cell.setup(viewModel: viewModel)
        }

        return cell
    }
}

// Refresh Controll
extension CharactersTableViewController {
    @objc func refreshData() {
        viewModel?.fetchData(completion: { (err) in
            if let err = err {
                print(err.description)
            } else {
                self.tableView.reloadData()
            }
            self.refreshControll.endRefreshing()
        })
    }
}
