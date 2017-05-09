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
        XCTAssertEqual("オハヨウゴザイマス".len, 9)
        XCTAssertEqual("ｵﾊﾖｳｺﾞｻﾞｲﾏｽ".len, 9)
    }

    func testHost() {
        let url = "https://google.com"
        XCTAssertEqual(url.host, "google.com")
    }

    func testBase64() {
        XCTAssertEqual("".base64(.encode), "")
        XCTAssertEqual("f".base64(.encode), "Zg==")
        XCTAssertEqual("fo".base64(.encode), "Zm8=")
        XCTAssertEqual("foo".base64(.encode), "Zm9v")
        XCTAssertEqual("foob".base64(.encode), "Zm9vYg==")
        XCTAssertEqual("fooba".base64(.encode), "Zm9vYmE=")
        XCTAssertEqual("foobar".base64(.encode), "Zm9vYmFy")
    }

    func testTrimmed() {
        XCTAssertEqual("  Ok,  fine!  ".trimmed, "Ok,  fine!")
    }
}
