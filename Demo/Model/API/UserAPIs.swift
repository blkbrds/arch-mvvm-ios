//
//  UserAPIs.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire

extension API.User {
    struct LoginParams {
        let name: String
        let pass: String
    }

    func login(params: LoginParams, completion: @escaping Completion) {
        api.session.credential = Session.Credential(
            name: params.name,
            pass: params.pass
        )
        api.request(method: HTTPMethod.get, urlString: ApiPath.User.login) { (result) in
            completion(result)
        }
    }
}
