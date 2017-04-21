//
//  UserAPIs.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension Api.User {
    struct LoginParams {
        let name: String
        let pass: String
    }

    // https://developer.github.com/v3/users/#get-the-authenticated-user
    @discardableResult
    func login(params: LoginParams, completion: @escaping Completion) -> Request? {
        api.session.credential = Session.Credential(
            name: params.name,
            pass: params.pass
        )
        let path = Api.Path.User.login
        return api.request(method: .get, urlString: path) { (result) in
            Mapper<User>().map(result: result, type: .object, completion: completion)
        }
    }
}
