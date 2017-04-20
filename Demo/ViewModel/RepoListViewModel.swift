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


final class RepoListViewModel: MVVM.CollectionViewModel {

    typealias Item = RepoCellViewModel
    weak var delegate: CollectionViewModelDelegate?
    private var repoViewModels = [Item]()
    private var token: NotificationToken?

    func reloadData() {
        Api.Repo.getAll { [weak self] results in
            guard let `self` = self else { return }
            switch results {
            case .success(let repos):
                repos.forEach({
                    let cellViewModel = RepoCellViewModel(repo: $0)
                    self.repoViewModels.append(cellViewModel)
                })
                self.delegate?.viewModel(change: .initial)
            case .failure(let error):
                self.delegate?.viewModel(change: .error(error))
            }
        }
    }

    // MARK: - Action

    func fetch() {
        DispatchQueue.global(qos: .background).async { [weak self] Void in
            guard let this = self else { return }
            this.execFetch()
        }
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

    // MARK: Private

    private func execFetch() {
//        repos = RealmS().objects(Repo.self).sorted(byKeyPath: "id", ascending: true)
//        token = repos?.addNotificationBlock({ [weak self] (change) in
//            guard let this = self else { return }
//            DispatchQueue.main.async {
//                this.delegate?.viewModel(change: change.changes)
//            }
//        })
    }

    var numberOfSections: Int {
        return 1
    }

    func numberOfRowsInSection(_ section: Int) -> Int {
        return repoViewModels.count
    }

    func itemForRow(at indexPath: IndexPath) -> RepoCellViewModel {
        return repoViewModels[indexPath.row]
    }
}
