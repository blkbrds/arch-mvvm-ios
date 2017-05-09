//
//  LoginViewControllerTests.swift
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

final class LoginViewControllerTests: XCTestCase {
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
        let vm = LoginViewModel.standard
        let vc = loginViewController()
        vc.viewModel = vm

        let usernameField: UITextField! = vc.usernameField
        XCTAssertNotNil(usernameField)
        XCTAssertEqual(usernameField.text, vm.username)

        let accessTokenField: UITextField! = vc.accessTokenField
        XCTAssertNotNil(accessTokenField)
        XCTAssertEqual(accessTokenField.text, vm.accessToken)
    }

    func testActionLogin() {
        ex = expectation(description: "testActionLogin")
        let vc = loginViewController()
        let vm = LoginViewModel.standard
        vc.usernameField.text = vm.username
        vc.accessTokenField.text = vm.accessToken
        vc.loginButton.sendActions(for: .touchUpInside)
        XCTAssertEqual(vc.viewModel.username, vm.username)
        XCTAssertEqual(vc.viewModel.accessToken, vm.accessToken)
        waitForExpectations(timeout: Timeout.forRequest)
    }

    @objc private func viewDidUpdated() {
        ex?.fulfill()
    }

    private func loginViewController() -> LoginViewController {
        let sb = UIStoryboard(name: "Auth", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "Login") as? LoginViewController else {
            fatalError()
        }
        vc.loadViewIfNeeded()
        return vc
    }
}
