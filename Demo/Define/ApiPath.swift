//
//  ApiPath.swift
//  MVVM
//
//  Created by DaoNV on 4/10/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class ApiPath {
    static let baseURL = "https://api.github.com"

    static var Users: String {
        return baseURL + "/users"
    }

    struct User: CustomStringConvertible {
        let id: String

        var description: String {
            return ApiPath.Users + "/id"
        }

        static var login: String { return ApiPath.baseURL + "/user" }
    }
}
