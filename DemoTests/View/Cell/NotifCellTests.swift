//
//  NotifCellTests.swift
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

class NotifCellTests: XCTestCase {
    func testUpdateView() {
        let vm = NotifCellViewModel.test
        let cell = NotifCell()
        cell.viewModel = vm
        XCTAssertEqual(cell.textLabel?.text, vm.name)
    }
}

extension NotifCellViewModel {
    static var test: NotifCellViewModel {
        let notifObj = Notif()
        notifObj.name = "notif name"
        notifObj.desc = "This your first repo"
        let vm = NotifCellViewModel(notif: notifObj)
        return vm
    }
}
