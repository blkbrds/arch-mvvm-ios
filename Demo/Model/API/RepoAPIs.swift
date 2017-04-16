//
//  RepoAPIs.swift
//  MVVM
//
//  Created by DaoNV on 4/10/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire

extension Api.Repo {
    struct QueryParams {
        let type: Type
        let sort: Sort
        let direction: Direction
    }

    // https://developer.github.com/v3/repos/#list-your-repositories
    @discardableResult
    static func query(params: QueryParams, completion: @escaping Completion) -> Request? {
        return api.request(method: .get, urlString: Api.Path.User.login) { (result) in
            completion(result)
        }
    }
}

enum Direction: String {
    case asc
    case desc
}

extension Api.Repo.QueryParams {
    enum `Type`: String {
        case all
        case owner
        case `public`
        case `private`
        case member
    }

    enum Sort: String {
        case created
        case updated
        case pushed
        case full_name
    }
}
