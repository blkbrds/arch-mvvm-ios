//
//  NotifListViewController.swift
//  Demo
//
//  Created by DaoNV on 5/21/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import MVVM

final class NotifListViewController: UITableViewController, MVVM.View {
    var viewModel = NotifListViewModel() {
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
        viewModel.getNotifs { [weak self] (result) in
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
}

extension NotifListViewController: CollectionViewModelDelegate {
    func viewModel(change changes: CollectionChanges) {
        updateView()
    }
}

extension NotifListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotifCell") as? NotifCell
            else { fatalError() }
        cell.viewModel = viewModel.itemForRow(at: indexPath)
        return cell
    }
}

// MARK: - Private
extension NotifListViewController {
    fileprivate func configTable() {
        tableView.register(NotifCell.self, forCellReuseIdentifier: "NotifCell")
        tableView.dataSource = self
    }

    fileprivate func updateView() {
        guard isViewLoaded else { return }
        tableView.reloadData()
        viewDidUpdated()
    }
}
