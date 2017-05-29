//
//  NotifListViewModelTests.swift
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

class NotifListViewModelTests: XCTestCase {
    override func setUp() {
        super.setUp()
        let login = LoginViewModel.standard
        api.session.credential = Session.Credential(
            name: login.username,
            pass: login.accessToken
        )
    }

    func testGetNotifs() {
        let ex = expectation(description: "testGetNotifs")
        let vm = NotifListViewModel()
        vm.fetch()
        vm.getNotifs { (result) in
            switch result {
            case .success:
                let repos = RealmS().objects(Notif.self)
                guard vm.numberOfSections() > 0 else { return }
                XCTAssertEqual(repos.count, vm.numberOfItems(inSection: 0))
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            ex.fulfill()
        }

        waitForExpectations(timeout: Timeout.forRequest)
    }
}
