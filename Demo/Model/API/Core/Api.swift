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
        static var users: String { return baseURL / "users" }
    }

    struct User {
    }

    struct Me {
    }

    struct Repo {
        var id: String
    }

    struct Notif {
        var id: String
    }

    struct Team {
        var id: String
    }
}

extension Api.Path {
    struct User: URLStringConvertible {
        var id: String
        var urlString: String { return "users" / id }
    }

    struct Me: URLStringConvertible {
        var urlString: String { return Api.Path.baseURL / "user" }
        var login: String { return urlString }
        var repos: String { return urlString / "repos" }
        var notifs: String { return urlString / "notifications" }
    }

    struct Team: URLStringConvertible {
        var id: Int
        var urlString: String { return "teams" / id }
    }
}

fileprivate protocol URLStringConvertible {
    var urlString: String { get }
}

extension URL: URLStringConvertible {
    fileprivate var urlString: String { return absoluteString }
}

extension String: URLStringConvertible {
    fileprivate var urlString: String { return self }
}

extension Int: URLStringConvertible {
    fileprivate var urlString: String { return String(describing: self) }
}

fileprivate func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
    return "\(lhs.urlString)/\(rhs.urlString)"
}
