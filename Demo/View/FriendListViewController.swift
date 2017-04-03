//
//  FriendListViewController.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import MVVM

class FriendListViewController: UIViewController {

    var data = UserProvider() { didSet { reloadData() } }

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadData()
    }

    private func configTable() {
        tableView.register(FriendCell.self, forCellReuseIdentifier: "FriendCell")
        tableView.dataSource = self
    }

    func reloadData() {
        guard isViewLoaded else { return }
        tableView.reloadData()
    }
}

extension FriendListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as? FriendCell
        else { fatalError() }
        let idx = indexPath.row
        let user = data.object(at: idx)
        cell.config(model: FriendCellViewModel(model: user))
        return cell
    }
}
