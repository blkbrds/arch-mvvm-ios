//
//  UserViewModelTests.swift
//  MVVMTests
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import XCTest
@testable import Demo

extension UserViewModel {
    static var standard: UserViewModel {
        let user = UserViewModel(model: nil)
        user.mail = "at.ios.mvvm@gmail.com"
        user.pass = "Abc@123"
        return user
    }
}

class UserViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        //
    }
    
    override func tearDown() {
        //
        super.tearDown()
    }

    func testValidateSuccess() {
        let user = UserViewModel.standard
        let validation = user.validate()
        switch validation {
        case .success: break
        case .failure(_, _):
            XCTAssertTrue(false, "`validation` must be `.success`")
        }
    }

    func testValidateFailureMail() {
        let user = UserViewModel.standard
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
        let user = UserViewModel.standard
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
        let user = UserViewModel.standard
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
