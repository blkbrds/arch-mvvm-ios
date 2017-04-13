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
        let mail: String
        let pass: String
    }

    func login(params: LoginParams, completion: @escaping Completion) {
        api.session.credential = Session.Credential(
            mail: params.mail,
            pass: params.pass
        )
        api.request(method: HTTPMethod.get, urlString: ApiPath.Users) { (result) in
            completion(result)
        }
    }
}
