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

final class RepoListViewModel: MVVM.ViewModel {
    typealias Item = RepoCellViewModel

    var repoViewModelsTypes: [CellPresentable.Type] = [RepoCellViewModel.self]
    private(set) var repoViewModels = [CellPresentable]()

    //MARK: - Events
    var didError: ((Error) -> Void)?
    var didUpdate: ((RepoListViewModel) -> Void)?
    var didSelectRepo: ((Repo) -> Void)?

    func reloadData() {
        API.Repo.getAll { [weak self] results in
            switch results {
            case .success(let repos):
                guard let `self` = self else { return }
                self.repoViewModels = repos.map {
                    self.viewModelFor(repo: $0)
                }
                self.didUpdate?(self)
            case .failure(let error):
                print(error)
            }
        }
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
