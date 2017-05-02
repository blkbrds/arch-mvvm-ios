//
//  RepoListViewModelTests.swift
//  MVVM
//
//  Created by DaoNV on 4/17/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import XCTest
import MVVM
import RealmSwift
import ObjectMapper
import RealmS

@testable import Demo

class RepoListViewModelTests: XCTestCase {
    var ex: XCTestExpectation?

    override func setUp() {
        super.setUp()
        let login = LoginViewModel.standard
        api.session.credential = Session.Credential(
            name: login.username,
            pass: login.token
        )
    }

    func testGetRepos() {
        ex = expectation(description: "testGetRepos")
        let viewModel = RepoListViewModel()
        viewModel.delegate = self
        viewModel.getRepos { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success(_):
                let repos = RealmS().objects(Repo.self)
                XCTAssertFalse(repos.isEmpty)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            this.ex?.fulfill()
        }
        waitForExpectations(timeout: Timeout.forRequest)
    }

    func testNumberOfRepo() {
        ex = expectation(description: "testNumberOfRepo")
        let repoListVM = RepoListViewModel()
        repoListVM.delegate = self
        repoListVM.getRepos { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                repoListVM.fetch()
                let repos = RealmS().objects(Repo.self)
                guard repoListVM.numberOfSections > 0 else { return }
                XCTAssertEqual(repos.count, repoListVM.numberOfRowsInSection(0))
            case .failure(_):
                break
            }
            this.ex?.fulfill()
        }
        waitForExpectations(timeout: Timeout.forRequest, handler: nil)
    }
}

extension RepoListViewModelTests: CollectionViewModelDelegate {
    func viewModel(change changes: CollectionChanges) {
        ex?.fulfill()
    }
}
