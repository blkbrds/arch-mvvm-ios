//
//  UserVMTests.swift
//  MVVMTests
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import XCTest
@testable import MVVM

extension UserVM {
    static var standard: UserVM {
        let user = UserVM()
        user.name = "Do Nam Trung"
        user.mail = "trungdn@gmail.com"
        user.pass = "Secret@123"
        return user
    }
}

class UserVMTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        //
    }
    
    override func tearDown() {
        //
        super.tearDown()
    }

    func test_validate_success() {
        let user = UserVM.standard
        let validation = user.validate()
        switch validation {
        case .success: break
        case .failure(_, _):
            XCTAssertTrue(false, "`validation` must be `.success`")
        }
    }

    func test_validate_failure_name() {
        let user = UserVM.standard
        user.name = "Trung"
        let validation = user.validate()
        switch validation {
        case .success:
            XCTAssertTrue(false, "`validation` must be `.failure`")
        case .failure(let key, let msg):
            XCTAssertEqual(key, "name", "`validation` must be failure with `key` = `name`")
            XCTAssertEqual(msg, "'name' too short", "`validation` must be failure with `msg` = `'name' too short`")
        }
    }

    func test_validate_failure_mail() {
        let user = UserVM.standard
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
    
    func test_validate_failure_pass() {
        let user = UserVM.standard
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

    func test_login_success() {
        let ex = expectation(description: "login")
        let user = UserVM.standard
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
