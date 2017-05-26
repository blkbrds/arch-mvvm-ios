//
//  NotifListViewControllerTests.swift
//  Demo
//
//  Created by Huynh Quang Tien on 5/25/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import XCTest
import MVVM
import RealmSwift
import ObjectMapper
import RealmS
@testable import Demo

class NotifListViewControllerTests: XCTestCase {
    var ex: XCTestExpectation?

    override func setUp() {
        super.setUp()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(viewDidUpdated), name: .viewDidUpdated, object: nil)
    }

    override func tearDown() {
        let nc = NotificationCenter.default
        nc.removeObserver(self)
        super.tearDown()
    }

    func testLoad() {
        ex = expectation(description: "testLoad")
        let vc = notifListViewController()
        vc.viewModel = NotifListViewModel()
        waitForExpectations(timeout: Timeout.forRequest)
        XCTAssertEqual(vc.tableView.numberOfSections, 1)
        XCTAssertEqual(vc.tableView.numberOfRows(inSection: 0), 5)
        XCTAssertEqual(vc.viewModel.viewModelForHeaderInSection(0).name, "notif name")
    }

    @objc private func viewDidUpdated() {
        ex?.fulfill()
    }

    private func notifListViewController() -> NotifListViewController {
        let sb = UIStoryboard(name: "Notif", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "NotifList") as? NotifListViewController else {
            fatalError()
        }
        vc.loadViewIfNeeded()
        return vc
    }
}

private final class NotifListViewModel: Demo.NotifListViewModel {
    override func numberOfSections() -> Int {
        return 1
    }

    override func numberOfItems(inSection section: Int) -> Int {
        return 5
    }

    override func viewModelForItem(at indexPath: IndexPath) -> NotifCellViewModel {
        return .test
    }

    override func viewModelForHeaderInSection(_ section: Int) -> NotifRepoCellViewModel {
        let notifObj = Notif()
        notifObj.name = "notif name"
        notifObj.desc = "This your first repo"
        let vm = NotifRepoCellViewModel(notif: notifObj)
        return vm
    }
}
