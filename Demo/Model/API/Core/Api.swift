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
        static let baseURL = "https://api.github.com"
    }

    // MARK: - Services properties define
    struct User {
    }

    struct Me {
    }

    struct Repo {
        let id: String
    }

    struct Notif {
        let id: String
    }
}

extension Api.Path {
    struct User: ApiPath {
        static var path: String { return baseURL / "users" }
        let id: String
        var urlString: String { return User.path / id }
    }

    struct Me: ApiPath {
        static var path: String { return Api.Path.baseURL / "user" }
        var urlString: String { return Me.path }
        var repos: String { return self / "repos" }
        var notifs: String { return self / "notifications" }
    }
}

protocol URLStringConvertible {
    var urlString: String { get }
}

protocol ApiPath: URLStringConvertible {
    static var path: String { get }
}

extension URL: URLStringConvertible {
    var urlString: String { return absoluteString }
}

extension Int: URLStringConvertible {
    var urlString: String { return String(describing: self) }
}

fileprivate func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
    return lhs.urlString + "/" + rhs.urlString
}

extension String: URLStringConvertible {
    var urlString: String { return self }
}

extension CustomStringConvertible where Self: URLStringConvertible {
    var urlString: String { return description }
}
