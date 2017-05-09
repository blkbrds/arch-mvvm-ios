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

final class RepoCellViewModelTests: XCTestCase {
    func testReturnFromRepoListViewModel() {
        let ex = expectation(description: "testReturnFromRepoListViewModel")
        let vm = RepoListViewModel()
        vm.fetch()
        vm.getRepos { [weak self] (result) in
            switch result {
            case .success:
                let repos = RealmS().objects(Repo.self).sorted(byKeyPath: "id", ascending: true)
                guard let repo = repos.first else { return }
                let indexPath = IndexPath(row: 0, section: 0)
                let item = vm.itemForRow(at: indexPath)
                XCTAssertEqual(item.name, repo.name)
                XCTAssertEqual(item.desc, repo.desc)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            ex.fulfill()
        }
        waitForExpectations(timeout: Timeout.forRequest)
    }
}
