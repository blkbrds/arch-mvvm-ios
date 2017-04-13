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

    var repoViewModelsTypes: [CellPresentable.Type] = [RepoCellViewModel.self]
    private(set) var repoViewModels = [CellPresentable]()

    //MARK: - Events
    var didError: ((Error) -> Void)?
    var didUpdate: ((RepoListViewModel) -> Void)?
    var didSelectRepo: ((Repo) -> Void)?

    var title: String {
        return "Your Repo (\(self.repoViewModels.count))"
    }

    var numberOfSections: Int {
        return 1
    }

    func numberOfRowsInSection(_ section: Int) -> Int {
        return repoViewModels.count
    }

    func reloadData() {
        RepoService.getRepos(
            success: { [weak self] repos in
                self?.repoViewModels = repos.map { self.viewModelFor($0) }
                self?.didUpdate?(self)
            },
            failure: { [weak self] error in
                self?.didError?(error)
            }
        )
    }

    private func viewModelFor(repo: Repo) -> CellPresentable {
        let viewModel = RepoCellViewModel(repo: repo)
        viewModel.didSelectRepo = { [weak self] repo in
            self?.didSelectRepo?(repo)
        }
        viewModel.didError = { [weak self] error in
            self?.didError?(error)
        }
        return viewModel
    }
}
