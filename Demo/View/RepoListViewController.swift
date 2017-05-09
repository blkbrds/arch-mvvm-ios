//
//  RepoListViewController.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import MVVM

final class RepoListViewController: UITableViewController, MVVM.View {
    var viewModel = RepoListViewModel() {
        didSet {
            updateView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
        viewModel.delegate = self
        viewModel.fetch()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navi = navigationController,
            let window = AppDelegate.shared.window {
            window.rootViewController = navi
        }
        viewModel.getRepos { [weak self] (result) in
            guard let this = self, let navi = this.navigationController else { return }
            switch result {
            case .success:
                break
            case .failure(let error):
                let alert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                navi.present(alert, animated: true, completion: nil)
            }
            this.viewDidUpdated()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

extension RepoListViewController: CollectionViewModelDelegate {
    func viewModel(change changes: CollectionChanges) {
        updateView()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell") as? RepoCell
            else { fatalError() }
        cell.viewModel = viewModel.itemForRow(at: indexPath)
        return cell
    }
}

// MARK: - Private
extension RepoListViewController {
    fileprivate func configTable() {
        tableView.register(RepoCell.self, forCellReuseIdentifier: "RepoCell")
        tableView.dataSource = self
    }

    fileprivate func updateView() {
        guard isViewLoaded else { return }
        tableView.reloadData()
        viewDidUpdated()
    }
}
