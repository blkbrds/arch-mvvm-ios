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
        user.username = "at-ios-mvvm"
        user.token = "101a6476440c30431a17" + "25c310d1abe049189b2a"
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
        user.username = "trung"
        let validation = user.validate()
        switch validation {
        case .success:
            XCTFail("`validation` must be `.failure`")
        case .failure(let key, let msg):
            XCTAssertEqual(key, "username", "`validation` must be failure with `key` = `username`")
            XCTAssertEqual(msg, "'username' too short", "`validation` must be failure with `msg` = `'username' too short`")
        }
    }

    func testValidateFailureToken() {
        let user = LoginViewModel.standard
        user.token = "1234"
        let validation = user.validate()
        switch validation {
        case .success:
            XCTFail("`validation` must be `.failure`")
        case .failure(let key, let msg):
            XCTAssertEqual(key, "token", "`validation` must be failure with `key` = `token`")
            XCTAssertEqual(msg, "'token' too short", "`validation` must be failure with `msg` = `'token' too short`")
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

    func testLoginFailure() {
        let ex = expectation(description: "login")
        let user = LoginViewModel.standard
        user.token = "123"
        user.login { (result) in
            switch result {
            case .success:
                XCTFail("`login result` must be `.failure`")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Failure: 'token' too short")
            }
            ex.fulfill()
        }
        waitForExpectations(timeout: 1.5)
    }
}
