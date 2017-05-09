//
//  DictionayTests.swift
//  Demo
//
//  Created by DaoNV on 5/9/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import XCTest
@testable import Demo

final class DictionayTests: XCTestCase {
    func testUpdateValues() {
        var json: [String: String] = [
            "first": "John",
            "last": "Smith"
        ]
        let update: [String: String] = [
            "last": "Geogre",
            "age": "30"
        ]
        let expect: [String: String] = [
            "first": "John",
            "last": "Geogre",
            "age": "30"
        ]
        json.updateValues(update)
        XCTAssertEqual(json, expect)
    }
}
