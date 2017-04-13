//
//  API.swift
//  MVVM
//
//  Created by DaoNV on 4/10/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire

typealias JSObject = [String: Any]
typealias JSArray = [JSObject]

typealias Completion = (Result<JSObject>) -> Void

let api = APIManager()

final class APIManager {
    let session = Session()

    var defaultHTTPHeaders: [String: String] {
        var headers: [String: String] = [:]
        if session.credential.isValid {
            headers["Authentication"] = "\(session.credential)"
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
