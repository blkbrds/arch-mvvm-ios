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
        user.mail = "at.ios.mvvm@gmail.com"
        user.pass = "Abc@123"
        return user
    }
}

class LoginViewModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
        //
    }

    override func tearDown() {
        //
        super.tearDown()
    }

    func testValidateSuccess() {
        let user = LoginViewModel.standard
        let validation = user.validate()
        switch validation {
        case .success: break
        case .failure(_, _):
            XCTAssertTrue(false, "`validation` must be `.success`")
        }
    }

    func testValidateFailureMail() {
        let user = LoginViewModel.standard
        user.mail = "trung@co.uk"
        let validation = user.validate()
        switch validation {
        case .success:
            XCTAssertTrue(false, "`validation` must be `.failure`")
        case .failure(let key, let msg):
            XCTAssertEqual(key, "mail", "`validation` must be failure with `key` = `mail`")
            XCTAssertEqual(msg, "'mail' too short", "`validation` must be failure with `msg` = `'mail' too short`")
        }
    }

    func testValidateFailurePass() {
        let user = LoginViewModel.standard
        user.pass = "1234"
        let validation = user.validate()
        switch validation {
        case .success:
            XCTAssertTrue(false, "`validation` must be `.failure`")
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
                XCTAssertTrue(false, "`login result` must be `.success`")
            }
            ex.fulfill()
        }
        waitForExpectations(timeout: 1.5)
    }
}
