//
//  CharactersViewController.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

class CharactersViewController: UITableViewController, Identifieable {
    var canFetch = true
    var canEdit = false
    var ids: [Int] = [] {
        didSet {
            fetchData()
        }
    }
    var page: Int = 0 {
        didSet {
            fetchData()
        }
    }

    var viewModel: CharactersViewModel = CharactersViewModel(items: [])

    @IBOutlet weak var refreshControll: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CharacterCell.self)
        refreshControl?.addTarget(self, action: #selector(self.fetchData), for: UIControl.Event.valueChanged)

        if canFetch == false {
            refreshControll.removeFromSuperview()
        }
        
    }
}

// TableViewDelegate
extension CharactersViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller: CharacterViewController = UIStoryboard.loadViewController()

        let item = viewModel.characters[indexPath.row]
        controller.characterId = item.characterId

        self.navigationController?.pushViewController(controller, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CharacterCell.height
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard refreshControll.isRefreshing == false
        else {
            return
        }

        let count = viewModel.characters.count

        if indexPath.row == count - 10 {
            page += 1
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return canEdit
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeFavoriteCharacter(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// UITableViewDataSource
extension CharactersViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CharacterCell = tableView.dequeueReusableCell(forIndexPath: indexPath)

        let item = viewModel.characters[indexPath.row]
        cell.setup(viewModel: item)

        return cell
    }
}

@objc extension CharactersViewController {
    fileprivate func fetchData() {
        NetworkManager.shared.characterStore.with(ids: ids, page: page) { (result) in
            switch result {
            case .success(let characters):
                if self.page <= 1 {
                    self.viewModel.resetCharacters(characters)
                    self.tableView.reloadData()
                } else {
                    let oldCount = self.viewModel.characters.count - 1
                    self.viewModel.addCharacters(characters)
                    let newCount = self.viewModel.characters.count - 1

                    let indexes: [IndexPath] = (oldCount..<newCount).map { IndexPath(row: $0, section: 0) }
                    self.tableView.insertRows(at: indexes, with: UITableView.RowAnimation.fade)
                }
                self.refreshControll.endRefreshing()
            case . failure(let err):
                self.viewModel.resetCharacters([])
                print(err.description)
                self.tableView.reloadData()
            }
        }
    }
}
