//
//  TeamViewControllerTests.swift
//  Demo
//
//  Created by Huynh Quang Tien on 6/1/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import XCTest
import MVVM
import RealmSwift
import ObjectMapper
import RealmS
@testable import Demo

class TeamViewControllerTests: XCTestCase {
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
        let vc = teamViewController()
        vc.viewModel = TeamViewModel.test
        vc.updateView()
        waitForExpectations(timeout: Timeout.forRequest)
        guard let vmDetail = vc.viewModel.teamDetailViewModel else { return }
        XCTAssertEqual(vc.nameLabel.text, vmDetail.name)
        XCTAssertEqual(vc.slugLabel.text, vmDetail.slug)
        XCTAssertEqual(vc.descLabel.text, vmDetail.desc)
        XCTAssertEqual(vc.memberCountLabel.text, vmDetail.memberCount)
        XCTAssertEqual(vc.repoCountLabel.text, vmDetail.repoCount)
    }

    @objc private func viewDidUpdated() {
        ex?.fulfill()
    }

    private func teamViewController() -> TeamViewController {
        let sb = UIStoryboard(name: "Team", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "TeamDetail") as? TeamViewController else {
            fatalError()
        }
        vc.loadViewIfNeeded()
        return vc
    }
}
