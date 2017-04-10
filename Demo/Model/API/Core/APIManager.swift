//
//  API.swift
//  MVVM
//
//  Created by DaoNV on 4/10/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

typealias JSObject = [String: Any]
typealias JSArray = [JSObject]

enum Result {
    case success(JSObject)
    case failure(Error)
}

typealias Completion = (Result)->Void

let api = APIManager()

final class APIManager {
    let session = Session()

    var defaultHTTPHeaders: [String: String] {
        var headers: [String: String] = [:]
        if let token = session.token {
            headers.updateValues(token.values)
        }
        return headers
    }
}

final class API {
    struct User {
        var id: Int
    }

    struct Repo {
        var id: Int
    }
}
