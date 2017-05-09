//
//  RepoListViewControllerTests.swift
//  Demo
//
//  Created by DaoNV on 5/8/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import XCTest
import MVVM
import RealmSwift
import ObjectMapper
import RealmS
@testable import Demo

final class RepoListViewControllerTests: XCTestCase {
    var ex: XCTestExpectation?

    override func setUp() {
        super.setUp()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(viewDidUpdated), name: NSNotification.Name(MVVM.ViewDidUpdatedNotification), object: nil)
    }

    override func tearDown() {
        let nc = NotificationCenter.default
        nc.removeObserver(self)
        super.tearDown()
    }
    
    func testLoad() {
        ex = expectation(description: "testLoad")
        let vc = repoListViewController()
        vc.viewModel = RepoListViewModel()
        waitForExpectations(timeout: Timeout.forRequest)
        XCTAssertEqual(vc.tableView.numberOfSections, 1)
        XCTAssertEqual(vc.tableView.numberOfRows(inSection: 0), 2)
    }

    @objc private func viewDidUpdated() {
        ex?.fulfill()
    }

    private func repoListViewController() -> RepoListViewController {
        let sb = UIStoryboard(name: "Repo", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "RepoList") as? RepoListViewController else {
            fatalError()
        }
        vc.loadViewIfNeeded()
        return vc
    }
}

private final class RepoListViewModel: Demo.RepoListViewModel {
    override var numberOfSections: Int { return 1 }
    override func numberOfRowsInSection(_ section: Int) -> Int { return 2 }
    override func itemForRow(at indexPath: IndexPath) -> RepoCellViewModel { return .test }
}


