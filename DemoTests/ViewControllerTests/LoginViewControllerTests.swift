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
    func testViewModelDidSet() {
        let vm = LoginViewModel.standard
        let sb = UIStoryboard(name: "Auth", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "Login") as? LoginViewController else {
            XCTFail()
            return
        }
        vc.loadViewIfNeeded()
        vc.viewModel = vm

        let usernameField: UITextField! = vc.textFields[.username]
        XCTAssertNotNil(usernameField)
        XCTAssertEqual(usernameField.text, vm.username)

        let accessTokenField: UITextField! = vc.textFields[.accessToken]
        XCTAssertNotNil(accessTokenField)
        XCTAssertEqual(accessTokenField.text, vm.accessToken)
    }
}
