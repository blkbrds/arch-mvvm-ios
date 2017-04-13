//
//  RepoCellViewModel.swift
//  MVVM
//
//  Created by DaoNV on 4/1/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import MVVM

protocol CellPresentable {
    static func registerCell(tableView: UITableView)
    func dequeueCell(with tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    func cellSelected()
}

final class RepoCellViewModel: MVVM.ViewModel {

    fileprivate(set) var repo: Repo!

    var didError: ((Error) -> Void)?
    var didSelectRepo: ((Repo) -> Void)?
    var name = ""
    var slug = ""

    init(repo: Repo) {
        name = repo.name
        slug = repo.slug
        self.repo = repo
    }
}

extension RepoCellViewModel: CellPresentable {
    static func registerCell(tableView: UITableView) {
        let nib = UINib(nibName: "RepoCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "RepoCell")
    }

    func dequeueCell(with tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as? RepoCell
        else { return fatalError("RepoCell invalid") }
        cell.viewModel = self
        return cell
    }

    func cellSelected() {
        self.didSelectRepo?(repo)
    }
}
