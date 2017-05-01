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
        ex = expectation(description: "testGetRepos")
        let repoVM = RepoListViewModel()
        repoVM.delegate = self
        repoVM.getRepos { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                repoVM.fetch()
                let repos = RealmS().objects(Repo.self).sorted(byKeyPath: "id", ascending: true)
                guard let firstRepo = repos.first else {return}
                let repo = repoVM.itemForRow(at: IndexPath(row: 0, section: 0))
                
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
