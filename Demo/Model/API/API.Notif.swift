//
//  API.Notif.swift
//  MVVM
//
//  Created by DaoNV on 4/10/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.Notif {
    struct QueryParams {
        let type: Type
        let sort: Sort
        let direction: Direction
    }

    // https://developer.github.com/v3/activity/notifications/#list-your-notifications
    @discardableResult
    static func query(params: Api.Notif.QueryParams, completion: @escaping Completion) -> Request? {
        let path = Api.Path.Me().notifs
        return api.request(method: .get, urlString: path) { (result) in
            Mapper<Notif>().map(result: result, type: .array, completion: { (result) in
                DispatchQueue.main.async {
                    completion(result)
                }
            })
        }
    }
}

extension Api.Notif.QueryParams {
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
        case fullName = "full_name"
    }
}
