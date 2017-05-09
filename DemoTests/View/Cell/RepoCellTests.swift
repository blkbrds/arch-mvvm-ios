//
//  RepoCellTests.swift
//  Demo
//
//  Created by DaoNV on 5/9/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import XCTest
import MVVM
import RealmSwift
import ObjectMapper
import RealmS
@testable import Demo

final class RepoCellTests: XCTestCase {
    func testUpdateView() {
        let vm = RepoCellViewModel.test
        let cell = RepoCell()
        cell.viewModel = vm
        XCTAssertEqual(cell.textLabel?.text, vm.name)
    }
}

extension RepoCellViewModel {
    static var test: RepoCellViewModel {
        let vm = RepoCellViewModel(repo: nil)
        vm.name = "repo name"
        vm.desc = "repo desc"
        return vm
    }
}
