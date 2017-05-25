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

class RepoListViewModel: MVVM.ViewModel {
    weak var delegate: ViewModelDelegate?

    private var repos: Results<Repo>?
    private var token: NotificationToken?

    func numberOfSections() -> Int {
        guard let _ = repos else {
            return 0
        }
        return 1
    }

    func numberOfItems(inSection section: Int) -> Int {
        guard let repos = repos else {
            return 0
        }
        return repos.count
    }

    func viewModelForItem(at indexPath: IndexPath) -> RepoCellViewModel {
        guard let repos = repos else {
            fatalError("Please call `fetch()` first.")
        }
        let repo = repos[indexPath.row]
        return RepoCellViewModel(repo: repo)
    }

    // MARK: - Action

    func fetch() {
        guard repos == nil else { return }
        repos = RealmS().objects(Repo.self).sorted(byKeyPath: "id", ascending: true)
        token = repos?.addNotificationBlock({ [weak self] (change) in
            guard let this = self else { return }
            this.notify(change: change)
        })
    }

    enum GetReposResult {
        case success
        case failure(Error)
    }

    typealias GetReposCompletion = (GetReposResult) -> Void

    func getRepos(completion: @escaping GetReposCompletion) {
        let params = Api.Repo.QueryParams(
            type: .all,
            sort: .fullName,
            direction: .desc
        )
        Api.Repo.query(params: params) { (result) in
            RealmS().refresh()
            switch result {
            case .success(_):
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
