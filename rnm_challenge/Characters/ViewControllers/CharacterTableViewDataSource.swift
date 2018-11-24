//
//  File.swift
//  rnm_challenge
//
//  Created by rokit on 24/11/2018.
//  Copyright © 2018 rok cresnik. All rights reserved.
//

import Foundation

import UIKit

class CharacterTableViewDataSource: NSObject, UITableViewDataSource {
    var items: [[CharacterCellProtocol]] = []
    var currentPage = 0

    convenience init(items: [CharacterCellProtocol] = [CharacterCellProtocol]()) {
        self.init()
        self.items = [items]
    }

    func item(for indexPath: IndexPath) -> CharacterCellProtocol {
        return items[indexPath.section][indexPath.row]
    }

    func addItems(newItems: [CharacterCellProtocol]) {
        items.append(newItems)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CharacterTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)

        let item = items[indexPath.section][indexPath.row]
        let viewModel = CharacterCellViewModel(item: item)
        cell.setup(viewModel: viewModel)

        return cell
    }
}

extension CharacterTableViewDataSource {
    func fetchData(completion: @escaping ((Int?, Err?) -> Void)) {
        NetworkApi.shared.all(page: currentPage) { (characters, err) in
            if let err = err {
                print(err.description)
            } else {
                DispatchQueue.main.async() {
                    self.addItems(newItems: characters)
                    completion(self.currentPage, nil)

                }
            }
        }
    }

    func fetchMore(completion: @escaping ((Int?, Err?) -> Void)) {
        currentPage += 1
        fetchData(completion: completion)
    }
}
