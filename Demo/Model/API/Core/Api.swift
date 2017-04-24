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
    }

    struct Me {
    }

    struct Repo {
        var id: String
    }
}

extension Api.Path {
    struct Me {
        static var path: String { return Api.Path.baseURL + "/user" }
        static var login: String { return path }
        static var repos: String { return Me.path + "/repos" }
    }
}
