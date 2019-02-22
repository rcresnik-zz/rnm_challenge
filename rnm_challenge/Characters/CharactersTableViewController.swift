//
//  CharactersViewController.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import UIKit

class CharactersTableViewController: UITableViewController {
    static let identifier = "CharactersTableViewController"
    var canEdit = false
    var viewModel: CharactersTableViewModel = CharactersTableViewModel(items: [], canFetch: false)

    @IBOutlet weak var refreshControll: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CharacterCell.self)
        refreshControl?.addTarget(self, action: #selector(self.refreshData), for: UIControl.Event.valueChanged)

        if viewModel.canFetch == false {
            refreshControll.removeFromSuperview()
        }
        refreshData()
    }
}

// TableViewDelegate
extension CharactersTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = UIStoryboard.loadViewController(identifier: CharacterViewController.identifier) as CharacterViewController

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
            fetchCharacterPage(viewModel.pageNumber + 1)
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
extension CharactersTableViewController {
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

// Refresh Controll
extension CharactersTableViewController {
    @objc func refreshData() {
        fetchCharacterPage(viewModel.pageNumber)
    }

    func fetchMore() {
        guard viewModel.canFetch == true
            else {
                let err = Err(description: "Not allowed to fetch!")
                print(err)
                return
        }
        let page = viewModel.pageNumber + 1

        fetchCharacterPage(page)
    }

    fileprivate func fetchCharacterPage(_ page: Int) {
        guard viewModel.canFetch == true
            else {
                let err = Err(description: "Not allowed to fetch!")
                print(err)
                return
        }

        NetworkManager.shared.characterService.all(page: page) { [weak self] (result) in
            switch result {
            case .success(let characters):
                if page == 1 {
                    self?.viewModel.resetCharacters(characters)
                    self?.tableView.reloadData()
                } else {
                    self?.viewModel.addCharacters(characters)
                }
                self?.refreshControll.endRefreshing()
            case . failure(let err):
                print(err.description)
            }
        }
    }
}
