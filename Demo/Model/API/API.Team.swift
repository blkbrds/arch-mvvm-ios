//
//  API.Team.swift
//  Demo
//
//  Created by Huynh Quang Tien on 5/26/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.Team {
    struct QueryParams {
        let teamId: Int
    }

    // https://developer.github.com/v3/orgs/teams/
    @discardableResult
    static func query(params: Api.Team.QueryParams, completion: @escaping Completion) -> Request? {
        let path = Api.Path.Team(id: params.teamId)
        return api.request(method: .get, urlString: path) { (result) in
            Mapper<Team>().map(result: result, type: .object, completion: { (result) in
                DispatchQueue.main.async {
                    completion(result)
                }
            })
        }
    }
}
