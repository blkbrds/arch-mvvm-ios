//
//  NotifCellViewModelTests.swift
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

class NotifCellViewModelTests: XCTestCase {
    func testReturnFromNotifListViewModel() {
        let ex = expectation(description: "testReturnFromNotifListViewModel")
        let vm = NotifListViewModel()
        vm.fetch()
        vm.getNotifs { (result) in
            switch result {
            case .success:
                let notifs = RealmS().objects(Notif.self).sorted(byKeyPath: "id", ascending: true)
                guard let notif = notifs.first else { break }
                let indexPath = IndexPath(row: 0, section: 0)
                let item = vm.viewModelForItem(at: indexPath)
                XCTAssertEqual(item.name, notif.name)
                XCTAssertEqual(item.desc, notif.desc)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            ex.fulfill()
        }

        waitForExpectations(timeout: Timeout.forRequest)
    }
}
