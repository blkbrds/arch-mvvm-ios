//
//  UserAPIs.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire

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
        return api.request(method: .get, urlString: Api.Path.User.login) { (result) in
            completion(result)
        }
    }
}
