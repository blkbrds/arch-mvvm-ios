//
//  LoginViewModelTests.swift
//  MVVMTests
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import XCTest
@testable import Demo

extension LoginViewModel {
    static var standard: LoginViewModel {
        let user = LoginViewModel(user: nil)
        user.name = "at-ios-mvvm"
        user.pass = "101a6476440c30431a17" + "25c310d1abe049189b2a"
        return user
    }
}

class LoginViewModelTests: XCTestCase {
    func testValidateSuccess() {
        let user = LoginViewModel.standard
        let validation = user.validate()
        switch validation {
        case .success: break
        case .failure(_, _):
            XCTFail("`validation` must be `.success`")
        }
    }

    func testValidateFailureName() {
        let user = LoginViewModel.standard
        user.name = "trung"
        let validation = user.validate()
        switch validation {
        case .success:
            XCTFail("`validation` must be `.failure`")
        case .failure(let key, let msg):
            XCTAssertEqual(key, "name", "`validation` must be failure with `key` = `name`")
            XCTAssertEqual(msg, "'name' too short", "`validation` must be failure with `msg` = `'name' too short`")
        }
    }

    func testValidateFailurePass() {
        let user = LoginViewModel.standard
        user.pass = "1234"
        let validation = user.validate()
        switch validation {
        case .success:
            XCTFail("`validation` must be `.failure`")
        case .failure(let key, let msg):
            XCTAssertEqual(key, "pass", "`validation` must be failure with `key` = `pass`")
            XCTAssertEqual(msg, "'pass' too short", "`validation` must be failure with `msg` = `'pass' too short`")
        }
    }

    func testLoginSuccess() {
        let ex = expectation(description: "login")
        let user = LoginViewModel.standard
        user.login { (result) in
            switch result {
            case .success: break
            case .failure(_):
                XCTFail("`login result` must be `.success`")
            }
            ex.fulfill()
        }
        waitForExpectations(timeout: 1.5)
    }
}
