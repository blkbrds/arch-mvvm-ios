//
//  Api.swift
//  MVVM
//
//  Created by DaoNV on 4/10/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class Api {
    struct Path {
        static var baseURL = "https://api.github.com"
        static var users: String { return baseURL + "/users" }

        struct User: CustomStringConvertible {
            let id: String
            var description: String { return Api.Path.users + "/id" }
            static var login: String { return Api.Path.baseURL + "/user" }
            var repos: String { return Api.Path.baseURL + "/user/login" }
        }
    }

    struct User {
        var id: Int
    }

    struct Repo {
        var id: Int
    }
}
