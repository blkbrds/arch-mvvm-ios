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

    private(set) var viewModel: RepoListViewModel!

    convenience init(viewModel: RepoListViewModel = RepoListViewModel()) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        bindToViewModel()
        reloadData()
    }

    private func configTable() {
        tableView.dataSource = self
        viewModel.repoViewModelsTypes.forEach { $0.registerCell(tableView: tableView) }
    }
    
    private func bindToViewModel() {
        viewModel.didUpdate = { [weak self] viewModel in
            self?.viewModel = viewModel
            self?.viewModelDidUpdate()
        }
        viewModel.didError = { [weak self] error in
            self?.viewModelDidError(error)
        }
        viewModel.didSelectRepo = { [weak self] error in
            // push to detail repo
        }
    }

    private func reloadData() {
        viewModel.reloadData()
    }

    private func viewModelDidUpdate() {
        title = viewModel.title
        tableView.reloadData()
    }

    private func viewModelDidError(_ error: Error) {
        UIAlertView(title: "Error", message: "viewModelDidError", delegate: nil, cancelButtonTitle: "OK").show()
    }
}

extension RepoListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.repoViewModels[indexPath.row].dequeueCell(with: tableView ,at: indexPath)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.repoViewModels[indexPath.row].cellSelected()
    }
}
