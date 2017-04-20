//
//  RepoListViewController.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import MVVM

final class RepoListViewController: UITableViewController {

    private(set) var viewModel = RepoListViewModel()

    convenience init(viewModel: RepoListViewModel = RepoListViewModel()) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        viewModel.delegate = self
        viewModel.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        guard let navi = navigationController else { return }
//        navi.viewControllers = [self]
    }

    private func configTable() {
        tableView.register(RepoCell.self, forCellReuseIdentifier: "RepoCell")
        tableView.dataSource = self
    }
    private func viewModelDidError(_ error: Error) {
        UIAlertView(title: "Error", message: "viewModelDidError", delegate: nil, cancelButtonTitle: "OK").show()
    }
}

extension RepoListViewController: CollectionViewModelDelegate {
    func viewModel(change changes: CollectionChanges) {
        tableView.reloadData()
    }
}

extension RepoListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell") as? RepoCell
        else { fatalError() }
        cell.viewModel = viewModel.itemForRow(at: indexPath)
        return cell
    }
}
