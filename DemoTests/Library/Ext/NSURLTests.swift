//
//  NSURLTests.swift
//  Demo
//
//  Created by DaoNV on 5/9/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import XCTest
@testable import Demo

final class NSURLTests: XCTestCase {
    func testInit() {
        for code in 100..<600 {
            guard let status = HTTPStatus(code: code) else { continue }
            XCTAssertEqual(status.code, code)
            XCTAssertGreaterThan(status.description.count, 0)
            let error = NSError(status: status)
            XCTAssertEqual(error.code, status.code)
            XCTAssertEqual(error.localizedDescription, status.description)
        }
    }
}
