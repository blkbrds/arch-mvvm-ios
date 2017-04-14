//
//  RepoListViewModel.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift
import RealmS
import MVVM

final class RepoListViewModel: MVVM.ViewModel, MVVM.Provider {
    typealias Item = RepoCellViewModel
    typealias ModelChanges = CollectionChanges
    var changesHandler: ((CollectionChanges) -> Void)?

    private var repos: Results<Repo>?
    private var token: NotificationToken?

    func fetch() {
        repos = RealmS().objects(Repo.self).sorted(byKeyPath: "id", ascending: true)
        token = repos?.addNotificationBlock({ (change) in

        })
    }

    var numberOfSections: Int {
        guard let _ = repos else {
            return 0
        }
        return 1
    }

    func numberOfRowsInSection(_ section: Int) -> Int {
        guard let repos = repos else {
            return 0
        }
        return repos.count
    }

    func itemForRow(at indexPath: IndexPath) -> RepoCellViewModel {
        guard let repos = repos else {
            fatalError("Please call `fetch()` first.")
        }
        let repo = repos[indexPath.row]
        return RepoCellViewModel(repo: repo)
    }

    func getRepos() {
        let params = Api.Repo.QueryParams(
            type: .all,
            sort: .full_name,
            direction: .desc
        )
        Api.Repo.query(params: params) { (result) in
        }
    }
}
