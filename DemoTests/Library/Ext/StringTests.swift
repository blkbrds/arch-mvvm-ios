//
//  StringTests.swift
//  Demo
//
//  Created by DaoNV on 5/8/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import XCTest
@testable import Demo

final class StringTests: XCTestCase {
    func testLen() {
        let str = "Ò ò o"
        XCTAssertEqual(str.len, 5)
    }

    func testHost() {
        let url = "https://google.com"
        XCTAssertEqual(url.host, "google.com")
    }

    func testBase64() {

    }

    func testTrimmed() {
        let msg = "  Ok,  fine!  "
        XCTAssertEqual(msg.trimmed, "Ok,  fine!")
    }
}
