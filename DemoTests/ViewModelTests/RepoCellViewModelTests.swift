//
//  RepoCellViewModelTests.swift
//  Demo
//
//  Created by TruongNV on 5/1/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import XCTest
import MVVM
import RealmSwift
import ObjectMapper
import RealmS

@testable import Demo

class RepoCellViewModelTests: XCTestCase {

    var ex: XCTestExpectation?

    func testRepoCellVMInit() {
        ex = expectation(description: "testRepoCellVMInit")
        let repoListVM = RepoListViewModel()
        repoListVM.delegate = self
        repoListVM.getRepos { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                repoListVM.fetch()
                let repos = RealmS().objects(Repo.self).sorted(byKeyPath: "id", ascending: true)
                guard let firstRepo = repos.first else { return }
                let indexPath = IndexPath(row: 0, section: 0)
                let repo = repoListVM.itemForRow(at: indexPath)

                XCTAssertEqual(repo.name, firstRepo.name)
                XCTAssertEqual(repo.desc, firstRepo.desc)
            case .failure(_):
                break
            }
            this.ex?.fulfill()
        }
        waitForExpectations(timeout: Timeout.forRequest, handler: nil)
    }
}

extension RepoCellViewModelTests: CollectionViewModelDelegate {
    func viewModel(change changes: CollectionChanges) {
        ex?.fulfill()
    }
}
