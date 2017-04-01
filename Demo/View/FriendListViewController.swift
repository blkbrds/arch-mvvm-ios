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

    var dataProvider: UserProvider?
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configTable()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadData()
    }

    func configTable() {
        tableView.register(FriendCell.self, forCellReuseIdentifier: "FriendCell")
        tableView.dataSource = self
    }

    func reloadData() {
        guard let _ = dataProvider, isViewLoaded else { return }
        tableView.reloadData()
    }
}

extension FriendListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = dataProvider else { return 0 }
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = dataProvider,
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell") as? FriendCell
        else { fatalError() }
        let idx = indexPath.row
        let model = data.object(at: idx)
        cell.model = FriendCell.ViewModel(model: model)
        return cell
    }
}
